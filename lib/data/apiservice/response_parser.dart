import 'dart:convert';

import 'package:http/http.dart' show Response;
import 'package:http/http.dart' as http;

import '../../../common/exception.dart';
import '../models/meta_response.dart';

class ResponseParser {
  Future<T> parseResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic> json) successHandler,
  ) async {
    final parsedJson = json.decode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var metaresponse = MetaResponse.fromJson(parsedJson['meta']);
      if (metaresponse.status == "success") {
        return successHandler(parsedJson['data']);
      } else {
        throw Exception('Request failed: ${metaresponse.message}');
      }
    } else {
      handleErrorResponse(response.statusCode, parsedJson, false);
      throw Exception(
          'Unexpected Error'); // this will never actually be reached
    }
  }

  Future<T> parseResponseMeta<T>(
    http.Response response,
    T Function(bool metaResponse) successHandler,
  ) async {
    final parsedJson = json.decode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var metaresponse = MetaResponse.fromJson(parsedJson['meta']);
      if (metaresponse.status == "success") {
        return successHandler(true);
      } else {
        throw Exception('Request failed: ${metaresponse.message}');
      }
    } else {
      handleErrorResponse(response.statusCode, parsedJson, true);
      throw Exception(
          'Unexpected Error'); // this will never actually be reached
    }
  }

  void handleErrorResponse(
      int statusCode, Map<String, dynamic> parsedJson, bool isMeta) {
    if (statusCode == 422) {
      final messageError = isMeta
          ? parsedJson['data']['errors'][0].toString()
          : parsedJson['errors'][0].toString();
      throw Exception('Request failed: $messageError');
    } else if (statusCode >= 400 && statusCode < 500) {
      var metaresponse = MetaResponse.fromJson(parsedJson['meta']);
      throw Exception('Request failed: ${metaresponse.message}');
    } else if (statusCode >= 500) {
      throw ServerException('Server Error');
    } else {
      throw UnknownException('Unknown Error');
    }
  }
}
