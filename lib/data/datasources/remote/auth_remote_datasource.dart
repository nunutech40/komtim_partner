import 'dart:convert';

import 'package:komtim_partner/data/models/login_response.dart';

import '../../../common/constat_endpoint.dart';
import '../http_service.dart';
import '../response_parser.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> doLogin(String username, String password);
  Future<bool> doLogout();
  Future<bool> sendForgotPassword(String email);
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
}
