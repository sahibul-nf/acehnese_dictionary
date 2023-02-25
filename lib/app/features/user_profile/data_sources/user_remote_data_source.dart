import 'dart:developer';

import 'package:acehnese_dictionary/app/constants/api.dart';
import 'package:acehnese_dictionary/app/features/user_profile/models/user_model.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:dio/dio.dart';

class UserProfileRemoteDataSource {
  late Dio dio;

  UserProfileRemoteDataSource(Dio? dio) {
    this.dio = dio ?? Dio();
  }

  // get user profile
  Future<UserModel> getUserProfile(String token) async {
    try {
      final response = await dio.get(
        Api.baseUrl + ApiPath.authCheck(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      final body = ApiResponse.fromJson(response.data);
      // log body meta message with key 'message, code'
      log(
        'Code: ${body.meta.code}, Message: ${body.meta.message}',
        name: 'getUserProfile',
        error: body.errors,
      );

      return UserModel.fromJson(body.data);
    } on DioError catch (e) {
      log("Request GET: ${e.response?.realUri}", name: "getUserProfile");
      log("Request Headers: ${e.response?.headers}", name: "getUserProfile");
      log("Response: ${e.response?.data['meta']['message']}",
          name: "getUserProfile", time: DateTime.now());
      throw ServerException();
    }
  }
}
