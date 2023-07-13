import 'dart:convert';

import 'package:komtim_partner/data/models/login_response.dart';

import '../../apiservice/constat_endpoint.dart';
import '../../apiservice/http_service.dart';
import '../../apiservice/response_parser.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> doLogin(String username, String password);
  Future<bool> doLogout();
  Future<bool> sendForgotPassword(String email);
  Future<bool> changePassword(
      String oldPass, String newPass, String confirmPass);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpService client;
  final ResponseParser responseParser;

  AuthRemoteDataSourceImpl(
      {required this.client, required this.responseParser});

  @override
  Future<bool> doLogout() async {
    final response = await client.requestWithToken(
      method: 'GET',
      url: Endpoints.logout,
    );
    return responseParser.parseResponseMeta<bool>(response, (_) => true);
  }

  @override
  Future<LoginResponse> doLogin(String username, String password) async {
    // Define body
    String body = json.encode({
      'username': username,
      'password': password,
    });

    final response = await client.requestWithoutToken(
      method: 'POST',
      url: Endpoints.login,
      body: body,
    );

    return responseParser.parseResponse<LoginResponse>(
        response, (json) => LoginResponse.fromJson(json));
  }

  @override
  Future<bool> sendForgotPassword(String email) async {
    String body = json.encode({
      'email': email,
    });

    final response = await client.requestWithoutToken(
        method: 'POST', url: Endpoints.forgotPassword, body: body);

    return responseParser.parseResponseMeta<bool>(response, (_) => true);
  }

  @override
  Future<bool> changePassword(
      String oldPass, String newPass, String confirmPass) async {
    String body = json.encode({
      'old_password': oldPass,
      'new_password': newPass,
      'confirm_password': confirmPass
    });

    final response = await client.requestWithToken(
        method: 'PUT', url: Endpoints.changePassword, body: body);

    return responseParser.parseResponseMeta<bool>(response, (_) => true);
  }
}
