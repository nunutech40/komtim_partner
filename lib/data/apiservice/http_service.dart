import 'package:http/http.dart' as http;
import 'package:komtim_partner/data/datasources/preferences/shared_pref.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HttpService {
  final http.Client client;
  SharedPref sharedPref;
  final Connectivity _connectivity;

  HttpService({required this.client, required this.sharedPref})
      : _connectivity = Connectivity();

  Future<void> _checkConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('No internet connection');
    }
  }

  Future<http.Response> _request({
    required String method,
    required String url,
    String? body,
    Map<String, String>? headers,
  }) async {
    Uri uri = Uri.parse(url);

    await _checkConnectivity();

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
