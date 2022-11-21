import 'package:http/http.dart' as http;

class RestApiService {
  static final _httpClient = http.Client();

  static Future<http.Response> get(String url) async {
    final response = await _httpClient.get(Uri.parse(url));
    return response;
  }

  static Future<http.Response> post(String url,
      {Map<String, String>? headers, body}) async {
    final response =
        await _httpClient.post(Uri.parse(url), headers: headers, body: body);
    return response;
  }
}
