import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'local_storage_service.dart';

class RestApiService {
  static final _httpClient = http.Client();
  final _dio = Dio();

  RestApiService.init() {
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Authorization'] =
        'Bearer ${LocalStorageService.getToken()}';
  }

  factory RestApiService() => RestApiService.init();

  // get request with query params and headers (optional) and return response with dio
  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      log("Request POST: ${response.requestOptions.uri}",
          name: "RestApiService");
      log("Request Headers: ${response.requestOptions.headers}",
          name: "RestApiService");
      log("Response: ${response.data['meta']['message']}",
          name: "RestApiService", time: DateTime.now());

      return response;
    } on DioError catch (e) {
      log("Request POST: ${e.response?.realUri}", name: "RestApiService");
      log("Request Headers: ${e.response?.headers}", name: "RestApiService");
      log("Response: ${e.response?.data['meta']['message']}",
          name: "RestApiService", time: DateTime.now());

      throw Exception([e.response?.statusCode, e.response?.data['errors']]);
    }
  }

  // static Future<http.Response> get(String url,
  //     {Map<String, String>? headers}) async {
  //   final uri = Uri.parse(url);
  //   final response = await _httpClient.get(
  //     uri,
  //     headers: headers,
  //   );
  //   return response;
  // }

  // post request with body and headers (optional) and return response
  Future<http.Response> post(String url,
      {Map<String, String>? headers, dynamic body}) async {
    final response =
        await _httpClient.post(Uri.parse(url), headers: headers, body: body);
    return response;
  }
}
