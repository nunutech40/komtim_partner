import 'dart:convert';

import 'package:komtim_partner/data/models/login_response.dart';
import 'package:komtim_partner/data/models/meta_response.dart';
import 'package:komtim_partner/domain/entities/login_model.dart';

import '../../../common/constants.dart';
import 'package:http/http.dart' as http;

import '../../../common/constat_endpoint.dart';
import '../../../common/exception.dart';
import 'http_service.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> doLogin(String username, String password);
  Future<bool> doLogout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpService client;

  AuthRemoteDataSourceImpl({required this.client});
  @override
  Future<bool> doLogout() async {
    final response = await client.postWithToken(Endpoints.logout, null);

    final parsedJson = json.decode(response.body);

    switch (response.statusCode) {
      case 200:
        var metaresponse = MetaResponse.fromJson(parsedJson['meta']);
        if (metaresponse.status == "success") {
          return true;
        } else {
          throw Exception('Logout failed: ${metaresponse.message}');
        }
      case 401:
        var metaresponse = MetaResponse.fromJson(parsedJson['meta']);
        throw UnauthorizedException(metaresponse.message ?? 'Unauthorized');
      case 404:
        var metaresponse = MetaResponse.fromJson(parsedJson['meta']);
        throw UnauthorizedException(metaresponse.message ?? 'Unauthorized');
      case 422:
        final messageError = parsedJson['data']['errors'][0].toString();
        throw UnauthorizedException(messageError);
      case 500:
        throw ServerException('Server Error');
      default:
        throw UnknownException('Unknown Error');
    }
  }

  @override
  Future<LoginResponse> doLogin(String username, String password) async {
    // Define body
    String body = json.encode({
      'username': username,
      'password': password,
    });

    final response = await client.postWithoutToken(Endpoints.login, body);

    final parsedJson = json.decode(response.body);

    switch (response.statusCode) {
      case 200:
        var metaresponse = MetaResponse.fromJson(parsedJson['meta']);
        if (metaresponse.status == "success") {
          return LoginResponse.fromJson(parsedJson['data']);
        } else {
          throw Exception('Login failed: ${metaresponse.message}');
        }
      case 401:
        var metaresponse = MetaResponse.fromJson(parsedJson['meta']);
        throw UnauthorizedException(metaresponse.message ?? 'Unauthorized');
      case 422:
        final messageError = parsedJson['data']['errors'][0].toString();
        throw UnauthorizedException(messageError);
      case 500:
        throw ServerException('Server Error');
      default:
        throw UnknownException('Unknown Error');
    }
  }
}
