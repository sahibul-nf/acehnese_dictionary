import 'dart:io';

import 'package:acehnese_dictionary/app/features/user_profile/data_sources/user_remote_data_source.dart';
import 'package:acehnese_dictionary/app/features/user_profile/models/user_model.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:acehnese_dictionary/app/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> getUserProfile(String token);
}

class UserRepositoryImpl implements UserRepository {
  final UserProfileRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserModel>> getUserProfile(String token) async {
    try {
      final result = await remoteDataSource.getUserProfile(token);
      return Right(result);
    } on SocketException catch (_) {
      return const Left(ConnectionFailure('No internet connection'));
    } on ServerException catch (_) {
      return const Left(ServerFailure(''));
    }
  }
}
