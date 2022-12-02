import 'dart:convert';
import 'dart:developer';

import 'package:acehnese_dictionary/app/utils/services/local_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

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

      log("Request GET: ${response.requestOptions.uri}",
          name: "RestApiService");
      log("Request Headers: ${response.requestOptions.headers}",
          name: "RestApiService");
      log("Response: ${response.data['meta']['message']}",
          name: "RestApiService", time: DateTime.now());

      return response;
    } on DioError catch (e) {
      log("Request GET: ${e.response?.realUri}", name: "RestApiService");
      log("Request Headers: ${e.response?.headers}", name: "RestApiService");
      log("Response: ${e.response?.data['meta']['message']}",
          name: "RestApiService", time: DateTime.now());

      throw Exception([e.response?.statusCode, e.response?.data['errors']]);
    }
  }

  // post request with body and headers (optional) and return response
  Future<http.Response> post(String url,
      {Map<String, String>? headers, dynamic body}) async {
    final response =
        await _httpClient.post(Uri.parse(url), headers: headers, body: body);
    return response;
  }

  // post request with body and headers (optional) and return response with dio
  Future<Response> postDio(String url,
      {dynamic body, Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post(
        url,
        data: jsonEncode(body),
        options: Options(headers: headers),
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
}
