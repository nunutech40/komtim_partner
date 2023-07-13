import 'package:http/http.dart' as http;
import 'package:komtim_partner/data/datasources/preferences/shared_pref.dart';

class HttpService {
  final http.Client client;
  SharedPref sharedPref;

  HttpService({required this.client, required this.sharedPref});

  Future<http.Response> _request({
    required String method,
    required String url,
    String? body,
    Map<String, String>? headers,
  }) async {
    Uri uri = Uri.parse(url);

    switch (method.toUpperCase()) {
      case 'POST':
        return await client.post(uri, headers: headers, body: body);
      case 'PUT':
        return await client.put(uri, headers: headers, body: body);
      case 'DELETE':
        return await client.delete(uri, headers: headers);
      case 'GET':
      default:
        return await client.get(uri, headers: headers);
    }
  }

  Future<http.Response> requestWithToken({
    required String method,
    required String url,
    String? body,
    Map<String, String>? headers,
  }) async {
    headers = headers ?? {'Content-Type': 'application/json; charset=UTF-8'};
    final token = await sharedPref.getToken();
    headers['Authorization'] = 'Bearer $token';

    return await _request(
        method: method, url: url, body: body, headers: headers);
  }

  Future<http.Response> requestWithoutToken({
    required String method,
    required String url,
    String? body,
    Map<String, String>? headers,
  }) async {
    headers = headers ?? {'Content-Type': 'application/json; charset=UTF-8'};
    return await _request(
        method: method, url: url, body: body, headers: headers);
  }
}
