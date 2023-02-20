import 'dart:io';

import 'package:acehnese_dictionary/app/features/auth/models/auth_model.dart';
import 'package:acehnese_dictionary/app/features/auth/respositories/auth_repository.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:acehnese_dictionary/app/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late AuthRepositoryImpl authRepository;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authRepository =
        AuthRepositoryImpl(remoteDataSource: mockAuthRemoteDataSource);
  });

  group('AuthRepositoryImpl', () {
    final tAuthModel = AuthModel(token: '');

    group('signIn', () {
      const email = 'sahibul@gmail';
      const password = 'sahibul';
      test('should return User when signIn successfully', () async {
        // arrange
        when(() => mockAuthRemoteDataSource.signIn(
            email: email, password: password)).thenAnswer(
          (_) async => tAuthModel,
        );

        // act
        final result =
            await authRepository.signIn(email: email, password: password);

        // assert
        verify(() =>
            mockAuthRemoteDataSource.signIn(email: email, password: password));
        expect(result, equals(Right(tAuthModel)));
      });

      // connection test
      test('should return ConnectionFailure when there is no internet',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource.signIn(
            email: email, password: password)).thenThrow(const SocketException('No internet connection'));

        // act
        final result =
            await authRepository.signIn(email: email, password: password);

        // assert
        verify(() =>
            mockAuthRemoteDataSource.signIn(email: email, password: password));
        expect(result, equals(const Left(ConnectionFailure('No internet connection'))));
      });

      // server test
      test('should return ServerFailure when server error', () async {
        // arrange
        when(() => mockAuthRemoteDataSource.signIn(
            email: email, password: password)).thenThrow(ServerException());

        // act
        final result =
            await authRepository.signIn(email: email, password: password);

        // assert
        verify(() =>
            mockAuthRemoteDataSource.signIn(email: email, password: password));
        expect(result, equals(const Left(ServerFailure(''))));
      });
    });
  });
}
