import 'dart:convert';

import 'package:acehnese_dictionary/app/constants/api.dart';
import 'package:acehnese_dictionary/app/features/user_profile/data_sources/user_remote_data_source.dart';
import 'package:acehnese_dictionary/app/features/user_profile/models/user_model.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fixture_reader.dart';
import '../helpers/mocks.dart';

void main() {
  late MockDio mockDio;
  late UserProfileRemoteDataSource userProfileRemoteDataSource;

  setUp(() {
    mockDio = MockDio();
    userProfileRemoteDataSource = UserProfileRemoteDataSource(mockDio);
  });

  group('UserProfileRemoteDataSource', () {
    final url = Api.baseUrl + ApiPath.authCheck();
    final jsonResponse = jsonDecode(fixture('user_response.json'));

    // test successful return UserModel
    test('should return UserModel when the response code is 200', () async {
      when(
        () => mockDio.get(
          url,
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: url),
          data: jsonResponse,
          statusCode: 200,
        ),
      );

      final result = await userProfileRemoteDataSource.getUserProfile('token');

      expect(result, isA<UserModel>());
    });

    // test throw ServerException when response code is not 200
    test('should throw ServerException when the response code is not 200',
        () async {
      when(
        () => mockDio.get(url, options: any(named: 'options')),
      ).thenThrow(ServerException());

      final call = userProfileRemoteDataSource.getUserProfile;

      expect(() => call('token'), throwsA(isA<ServerException>()));
    });
  });
}
