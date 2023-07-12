import 'dart:convert';

import 'package:http/http.dart' show Response;

import '../../../common/exception.dart';
import '../models/meta_response.dart';

class ResponseParser {
  Future<T> parseResponse<T>(
    Response response,
    T Function(Map<String, dynamic> json) successHandler,
  ) async {
    final parsedJson = json.decode(response.body);

    switch (response.statusCode) {
      case 200:
        var metaresponse = MetaResponse.fromJson(parsedJson['meta']);
        if (metaresponse.status == "success") {
          return successHandler(parsedJson['data']);
        } else {
          throw Exception('Request failed: ${metaresponse.message}');
        }
      case 204:
        var metaresponse = MetaResponse.fromJson(parsedJson['meta']);
        throw UnauthorizedException(metaresponse.message ?? 'Not Found');
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

  Future<T> parseResponseMeta<T>(
    Response response,
    T Function(bool metaResponse) successHandler,
  ) async {
    final parsedJson = json.decode(response.body);

    switch (response.statusCode) {
      case 200:
        var metaresponse = MetaResponse.fromJson(parsedJson['meta']);
        if (metaresponse.status == "success") {
          return successHandler(true);
        } else {
          throw Exception('Request failed: ${metaresponse.message}');
        }
      case 401:
        throw UnauthorizedException('Unauthorized');
      case 404:
        throw UnauthorizedException('Not found');
      case 422:
        final messageError = parsedJson['errors'][0].toString();
        throw UnauthorizedException(messageError);
      case 500:
        throw ServerException('Server Error');
      default:
        throw UnknownException('Unknown Error');
    }
  }
}
