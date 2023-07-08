import 'dart:convert';

import 'package:komtim_partner/data/models/login_response.dart';
import 'package:komtim_partner/data/models/meta_response.dart';
import 'package:komtim_partner/domain/entities/login_model.dart';

import '../../../common/constants.dart';
import 'package:http/http.dart' as http;

import '../../../common/exception.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> doLogin(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<LoginResponse> doLogin(String username, String password) async {
    // Define headers
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    // Define body
    String body = json.encode({
      'username': username,
      'password': password,
    });

    final response = await client.post(
      Uri.parse('$BaseURL/api/v1/auth/login'),
      headers: headers,
      body: body,
    );

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
