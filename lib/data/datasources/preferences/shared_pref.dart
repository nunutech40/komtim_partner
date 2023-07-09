import 'dart:async';

import 'package:komtim_partner/common/constants.dart';
import 'package:komtim_partner/data/models/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  final Future<SharedPreferences> sharedPreferences;
  final StreamController<bool> _loginController = StreamController<bool>();

  SharedPref({required this.sharedPreferences, required});

  Stream<bool> get isLoggedInStream => _loginController.stream;

  Future<void> saveUserAndToken(LoginResponse userAndToken) async {
    final prefs = await sharedPreferences;
    String userAndTokenJson = jsonEncode(userAndToken.toJson());
    await prefs.setString(USERANDTOKEN, userAndTokenJson);
    _loginController.add(true); // Add true to the stream when a token is saved.
  }

  Future<bool> isLoggedIn() async {
    final prefs = await sharedPreferences;
    String? userAndTokenJson = prefs.getString(USERANDTOKEN);
    if (userAndTokenJson == null) {
      _loginController
          .add(false); // Add false to the stream when there is no token.
      return false;
    }

    String? token =
        LoginResponse.fromJson(jsonDecode(userAndTokenJson)).accessToken;
    bool isLoggedIn = token != null;
    _loginController.add(isLoggedIn); // Add the login status to the stream.
    return isLoggedIn;
  }
}
