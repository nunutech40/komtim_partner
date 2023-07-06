import 'dart:convert';

import 'package:komtim_partner/data/models/login_response.dart';
import 'package:komtim_partner/domain/entities/login_model.dart';

import '../../../common/constants.dart';
import 'package:http/http.dart' as http;

import '../../../common/exception.dart';

abstract class AuthRemoteDataSource {
  Future<LoginDataResponse> doLogin(
      String username, String password, String loginFrom, String fcmToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<LoginDataResponse> doLogin(String username, String password,
      String loginFrom, String fcmToken) async {
    // Define headers
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    // Define body
    String body = json.encode({
      'username_email': username,
      'password': password,
      'login_from': loginFrom,
      'fcm_token': fcmToken,
    });

    final response = await client.post(
      Uri.parse('$BaseURL/mobile/login'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      // decode data from json
      var loginResponse = LoginResponse.fromJson(json.decode(response.body));

      if (loginResponse.status == "success") {
        return loginResponse.data;
      } else {
        throw Exception('Login failed: ${loginResponse.message}');
      }
    } else {
      throw ServerException();
    }
  }
}
