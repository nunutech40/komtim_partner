import 'package:komtim_partner/common/constants.dart';
import 'package:komtim_partner/data/models/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  final Future<SharedPreferences> sharedPreferences;
  SharedPref({required this.sharedPreferences});

  Future<void> saveUserAndToken(LoginResponse userAndToken) async {
    final prefs = await sharedPreferences;
    String userAndTokenJson = jsonEncode(userAndToken.toJson());
    prefs.setString(UserAndToken, userAndTokenJson);
  }

  Future<LoginResponse> getUserAndToken() async {
    final prefs = await sharedPreferences;
    String? userAndTokenJson = prefs.getString(UserAndToken);
    if (userAndTokenJson != null) {
      return LoginResponse.fromJson(jsonDecode(userAndTokenJson));
    }
    throw Exception('No UserAndTokenEntity found in preferences');
  }
}
