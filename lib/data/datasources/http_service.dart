import 'package:http/http.dart' as http;
import 'package:komtim_partner/data/datasources/preferences/shared_pref.dart';

class HttpService {
  final http.Client client;
  SharedPref sharedPref;

  HttpService({required this.client, required this.sharedPref});

  Future<http.Response> postWithToken(String url, String? body,
      {Map<String, String>? headers}) async {
    // Add your token to the headers
    headers = headers ?? {'Content-Type': 'application/json; charset=UTF-8'};
    final token = await sharedPref.getToken();
    headers['Authorization'] = 'Bearer $token';

    // Make the POST request
    final response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    return response;
  }

  Future<http.Response> postWithoutToken(String url, String? body,
      {Map<String, String>? headers}) async {
    // Add a default content type header if none is provided
    headers = headers ?? {'Content-Type': 'application/json; charset=UTF-8'};

    // Make the POST request
    final response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    return response;
  }

  // Implement other methods like getWithToken, getWithoutToken etc.
}
