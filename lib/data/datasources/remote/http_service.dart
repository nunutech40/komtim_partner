import 'package:http/http.dart' as http;

class HttpService {
  final http.Client client;

  HttpService({required this.client});

  Future<http.Response> postWithToken(String url, String? body,
      {Map<String, String>? headers}) async {
    // Add your token to the headers
    headers = headers ?? {'Content-Type': 'application/json; charset=UTF-8'};
    headers['Authorization'] = 'Bearer your_token_here';

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
