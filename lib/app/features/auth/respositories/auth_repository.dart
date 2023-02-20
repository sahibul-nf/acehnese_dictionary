import 'dart:io';

import 'package:acehnese_dictionary/app/features/auth/data_sources/auth_remote_data_source.dart';
import 'package:acehnese_dictionary/app/features/user_profile/models/user_model.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:acehnese_dictionary/app/utils/failure.dart';
import 'package:dartz/dartz.dart';

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
  AuthRepositoryImpl({required this.remoteDataSource});

  final AuthRemoteDataSourceImpl remoteDataSource;

  @override
  Future<Either<Failure, UserModel>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.signUp(
        email: email,
        password: password,
        name: name,
      );

      return Right(response);
    } on SocketException catch (_) {
      return const Left(ConnectionFailure('No internet connection'));
    } on ServerException catch (_) {
      return const Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> signIn(
      {required String email, required String password}) async {
    try {
      final response = await remoteDataSource.signIn(
        email: email,
        password: password,
      );

      return Right(response);
    } on SocketException catch (_) {
      return const Left(ConnectionFailure('No internet connection'));
    } on InvalidCredentialException catch (_) {
      return const Left(InvalidCredentialFailure('invalid credential'));
    } on ServerException catch (_) {
      return const Left(ServerFailure(''));
    }
  }
}
