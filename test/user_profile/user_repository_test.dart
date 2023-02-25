import 'dart:io';

import 'package:acehnese_dictionary/app/features/user_profile/models/user_model.dart';
import 'package:acehnese_dictionary/app/features/user_profile/repositories/user_repositories.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:acehnese_dictionary/app/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late UserRepositoryImpl userRepositoryImpl;

  setUp(() {
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    userRepositoryImpl =
        UserRepositoryImpl(remoteDataSource: mockUserRemoteDataSource);
  });

  final tUserModel = UserModel(
    id: 1,
    name: 'Sahibul',
    email: 'sahibul@gmail',
    avatarUrl: '',
  );

  group('UserRepositoryImpl', () {
    test('should return UserModel when getUser successfully', () async {
      // arrange
      when(() => mockUserRemoteDataSource.getUserProfile('token'))
          .thenAnswer((_) async => tUserModel);

      // act
      final result = await userRepositoryImpl.getUserProfile('token');

      // assert
      verify(() => mockUserRemoteDataSource.getUserProfile('token'));
      final resultUser = result.getOrElse(() => tUserModel);
      expect(resultUser, tUserModel);
    });

    test('should return ConnectionFailure when internet connection is lost',
        () async {
      // arrange
      when(() => mockUserRemoteDataSource.getUserProfile('token'))
          .thenThrow(const SocketException('No internet connection'));

      // act
      final result = await userRepositoryImpl.getUserProfile('token');

      // assert
      verify(() => mockUserRemoteDataSource.getUserProfile('token'));
      expect(result, equals(const Left(ConnectionFailure('No internet connection'))));
    });

    test('should return ServerFailure when server error', () async {
      // arrange
      when(() => mockUserRemoteDataSource.getUserProfile('token'))
          .thenThrow(ServerException());

      // act
      final result = await userRepositoryImpl.getUserProfile('token');

      // assert
      verify(() => mockUserRemoteDataSource.getUserProfile('token'));
      expect(result, equals(const Left(ServerFailure(''))));
    });
  });
}
