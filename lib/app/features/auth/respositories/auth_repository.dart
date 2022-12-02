import 'package:acehnese_dictionary/app/features/user_profile/models/user_model.dart';
import 'package:acehnese_dictionary/app/utils/failure.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

import '../../../constants/api.dart';
import '../../../utils/services/rest_api_service.dart';
import '../models/auth_model.dart';

abstract class AuthRepository {
  // sign up
  Future<Either<Failure, UserModel>> signUp({
    required String name,
    required String email,
    required String password,
  });
  // sign in
  Future<Either<Failure, AuthModel>> signIn({
    required String email,
    required String password,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, UserModel>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final connectifityResult = await Connectivity().checkConnectivity();
    if (connectifityResult == ConnectivityResult.none) {
      return Left(ConnectionFailure("No Internet Connection"));
    }

    try {
      final response = await RestApiService().postDio(
        Api.baseUrl + ApiPath.signUp(),
        body: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode != 200) {
        return Left(ServerFailure(response.data['meta']['message']));
      }

      final data = response.data['data'];
      if (data == null) {
        return Left(ServerFailure(response.data['meta']['message']));
      }

      final userModel = UserModel.fromJson(data);
      return Right(userModel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> signIn(
      {required String email, required String password}) async {
    final connectifityResult = await Connectivity().checkConnectivity();
    if (connectifityResult == ConnectivityResult.none) {
      return Left(ConnectionFailure("No Internet Connection"));
    }

    try {
      final response = await RestApiService().postDio(
        Api.baseUrl + ApiPath.signIn(),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode != 200) {
        return Left(ServerFailure(response.data['meta']['message']));
      }

      final data = response.data['data'];
      if (data == null) {
        return Left(ServerFailure(response.data['meta']['message']));
      }

      final authModel = AuthModel.fromJson(data);
      return Right(authModel);
    } catch (e) {
      return Left(ConnectionFailure(e.toString()));
    }
  }
}
