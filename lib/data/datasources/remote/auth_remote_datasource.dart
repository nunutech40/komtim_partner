import 'dart:convert';

import 'package:komtim_partner/data/datasources/remote/response_parser.dart';
import 'package:komtim_partner/data/models/login_response.dart';
import 'package:komtim_partner/data/models/meta_response.dart';
import 'package:komtim_partner/domain/entities/login_model.dart';

import '../../../common/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Response;

import '../../../common/constat_endpoint.dart';
import '../../../common/exception.dart';
import 'http_service.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> doLogin(String username, String password);
  Future<bool> doLogout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpService client;
  final ResponseParser responseParser;

  AuthRemoteDataSourceImpl(
      {required this.client, required this.responseParser});

  @override
  Future<bool> doLogout() async {
    final response = await client.postWithToken(Endpoints.logout, null);
    return responseParser.parseResponse<bool>(response, (_) => true);
  }

  @override
  Future<LoginResponse> doLogin(String username, String password) async {
    // Define body
    String body = json.encode({
      'username': username,
      'password': password,
    });

    final response = await client.postWithoutToken(Endpoints.login, body);
    return responseParser.parseResponse<LoginResponse>(
        response, (json) => LoginResponse.fromJson(json));
  }
}
