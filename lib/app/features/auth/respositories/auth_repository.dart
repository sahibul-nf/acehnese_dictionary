import 'dart:convert';

import 'package:acehnese_dictionary/app/features/auth/models/auth_response.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../constants/api.dart';
import '../../../utils/services/rest_api_service.dart';
import '../models/auth_model.dart';

abstract class AuthRepository {
  // sign up
  Future<AuthResponse> signUp({
    required String name,
    required String email,
    required String password,
  });
  // sign in
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<AuthResponse> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final connectifityResult = await Connectivity().checkConnectivity();
    if (connectifityResult == ConnectivityResult.none) {
      return AuthResponse(
        message: 'No Internet Connection',
        statusCode: 0,
      );
    }

    final response = await RestApiService.post(
      Api.baseUrl + ApiPath.signUp(),
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    final body = ApiResponse.fromJson(response.body);

    if (response.statusCode != 200) {
      return AuthResponse(
        message: body.meta.message,
        statusCode: response.statusCode,
        errors: body.errors.toString(),
        data: null,
      );
    }

    final data = AuthModel.fromJson(body.data);

    return AuthResponse(
      message: body.meta.message,
      statusCode: response.statusCode,
      data: data,
    );
  }
  
  @override
  Future<AuthResponse> signIn({required String email, required String password}) async {
    final connectifityResult = await Connectivity().checkConnectivity();
    if (connectifityResult == ConnectivityResult.none) {
      return AuthResponse(
        message: 'No Internet Connection',
        statusCode: 0,
      );
    }

    final response = await RestApiService.post(
      Api.baseUrl + ApiPath.signIn(),
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    final body = ApiResponse.fromJson(response.body);

    if (response.statusCode != 200) {
      return AuthResponse(
        message: body.meta.message,
        statusCode: response.statusCode,
        errors: body.errors.toString(),
        data: null,
      );
    }

    final data = AuthModel.fromJson(body.data);

    return AuthResponse(
      message: body.meta.message,
      statusCode: response.statusCode,
      data: data,
    );
  }
}
