import 'dart:convert';

import 'package:acehnese_dictionary/app/constants/api.dart';
import 'package:acehnese_dictionary/app/features/bookmark/data_sources/bookmark_remote_data_source.dart';
import 'package:acehnese_dictionary/app/features/bookmark/models/bookmark.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fixture_reader.dart';
import '../helpers/mocks.dart';

void main() {
  late MockDio dio;
  late BookmarkRemoteDataSourceImpl dataSource;

  setUp(() {
    dio = MockDio();
    dataSource = BookmarkRemoteDataSourceImpl(dio);
  });

  // mark & unmark word
  group('markOrUnmarkWord: ', () {
    final url = Api.baseUrl + ApiPath.markOrUnmarkWord();
    const tDictionaryId = 1;

    test('should return Bookmark when the response code is 200 (success)',
        () async {
      // arrange

      when(() => dio.post(url, data: any(named: 'data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: url),
          data: jsonDecode(fixture('mark_unmark_word_response.json')),
          statusCode: 200,
        ),
      );

      // act
      final result = await dataSource.markOrUnmarkWord(tDictionaryId);

      // assert
      expect(result, isA<Bookmark>());
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      // arrange
      when(() => dio.post(url, data: any(named: 'data')))
          .thenThrow(ServerException());

      // act
      final call = dataSource.markOrUnmarkWord;

      // assert
      expect(() => call(tDictionaryId), throwsA(isA<ServerException>()));
    });
  });
}
