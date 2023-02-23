import 'dart:convert';
import 'dart:math';

import 'package:acehnese_dictionary/app/constants/api.dart';
import 'package:acehnese_dictionary/app/features/auth/data_sources/auth_remote_data_source.dart';
import 'package:acehnese_dictionary/app/features/auth/models/auth_model.dart';
import 'package:acehnese_dictionary/app/features/user_profile/models/user_model.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fixture_reader.dart';
import '../helpers/mocks.dart';

void main() {
  late MockDio mockDio;
  late AuthRemoteDataSourceImpl authRemoteDataSource;

  setUp(() {
    mockDio = MockDio();
    authRemoteDataSource = AuthRemoteDataSourceImpl(mockDio);
  });

  group('AuthRemoteDataSource', () {
    group('signIn', () {
      final url = Api.baseUrl + ApiPath.signIn();
      const email = 'sahibul@gmail';
      const password = 'sahibul';

      test('should return true when the response is 200', () async {
        // arrange
        when(
          () => mockDio.post(url, data: {
            'email': email,
            'password': password,
          }),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: url),
            data: jsonDecode(fixture('sign_in_response.json')),
            statusCode: 200,
          ),
        );

        // act
        final result =
            await authRemoteDataSource.signIn(email: email, password: password);

        // assert
        expect(result, isA<AuthModel>());
      });

      test('should throw ServerException when the response is not 200',
          () async {
        // arrange
        when(
          () => mockDio.post(url, data: {
            'email': email,
            'password': password,
          }),
        ).thenThrow(ServerException());

        // act
        final call = authRemoteDataSource.signIn;

        // assert
        expect(() => call(email: email, password: password),
            throwsA(isA<ServerException>()));
      });
    });
  });

  group('signUp', () {
    final url = Api.baseUrl + ApiPath.signUp();

    int id = Random().nextInt(100);
    final email = 'test$id@gmail';
    final name = 'test_$id';
    const password = 'test';

    test('should return UserModel when the response is 200', () async {
      // arrange
      when(
        () => mockDio.post(url, data: {
          'name': name,
          'email': email,
          'password': password,
        }),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: url),
          data: jsonDecode(fixture('sign_up_response.json')),
          statusCode: 200,
        ),
      );

      // act
      final result = await authRemoteDataSource.signUp(
        name: name,
        email: email,
        password: password,
      );

      // assert
      expect(result, isA<UserModel>());
    });

    test('should throw ServerException when the response is not 200', () async {
      // arrange
      when(
        () => mockDio.post(url, data: {
          'name': name,
          'email': email,
          'password': password,
        }),
      ).thenThrow(ServerException());

      // act
      final call = authRemoteDataSource.signUp;

      // assert
      expect(
        () => call(name: name, email: email, password: password),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
