import 'dart:async';

import 'package:komtim_partner/common/constants.dart';
import 'package:komtim_partner/data/models/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  final Future<SharedPreferences> sharedPreferences;

  SharedPref({required this.sharedPreferences, required});

  Future<void> saveUserAndToken(LoginResponse userAndToken) async {
    final prefs = await sharedPreferences;
    String userAndTokenJson = jsonEncode(userAndToken.toJson());
    await prefs.setString(USERANDTOKEN, userAndTokenJson);
  }

  Future<void> removeDataPref() async {
    final prefs = await sharedPreferences;
    prefs.clear();
    final getLogin = await isLoggedIn();
  }

  Future<bool> isLoggedIn() async {
    final prefs = await sharedPreferences;
    String? userAndTokenJson = prefs.getString(USERANDTOKEN);
    if (userAndTokenJson == null) {
      return false;
    }

    String? token =
        LoginResponse.fromJson(jsonDecode(userAndTokenJson)).accessToken;
    bool isLoggedIn = token != null;
    return isLoggedIn;
  }
}
