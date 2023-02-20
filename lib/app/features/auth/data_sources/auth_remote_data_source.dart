import 'dart:developer';

import 'package:acehnese_dictionary/app/constants/api.dart';
import 'package:acehnese_dictionary/app/features/auth/models/auth_model.dart';
import 'package:acehnese_dictionary/app/features/user_profile/models/user_model.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  // sign up
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });

  // sign in
  Future<AuthModel> signIn({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  late Dio dio;

  AuthRemoteDataSourceImpl(Dio? dio) {
    this.dio = dio ?? Dio();
  }

  @override
  Future<AuthModel> signIn(
      {required String email, required String password}) async {
    try {
      final response = await dio.post(
        Api.baseUrl + ApiPath.signIn(),
        data: {
          'email': email,
          'password': password,
        },
      );

      final body = ApiResponse.fromJson(response.data);

      // log body meta message with key 'message, code'
      log(
        'Code: ${body.meta.code}, Message: ${body.meta.message}',
        name: 'signIn',
        error: body.errors,
      );

      return AuthModel.fromJson(body.data);
    } on DioError catch (e) {
      log(
        'Code: ${e.response?.statusCode}, Message: ${e.response?.statusMessage}',
        name: 'signIn',
        error: e.response?.statusMessage,
      );

      if (e.response?.statusCode == 401) {
        throw InvalidCredentialException();
      }

      throw ServerException();
    }
  }

  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      Api.baseUrl + ApiPath.signUp(),
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final body = ApiResponse.fromJson(response.data);

    // log body meta message with key 'message, code'
    log(
      'Code: ${body.meta.code}, Message: ${body.meta.message}',
      name: 'signUp',
      error: body.errors,
    );

    return UserModel.fromJson(body.data);
  }
}
