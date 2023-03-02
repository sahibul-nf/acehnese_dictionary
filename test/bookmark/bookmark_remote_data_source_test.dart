import 'dart:convert';

import 'package:acehnese_dictionary/app/constants/api.dart';
import 'package:acehnese_dictionary/app/features/bookmark/data_sources/bookmark_remote_data_source.dart';
import 'package:acehnese_dictionary/app/features/bookmark/models/bookmark.dart';
import 'package:acehnese_dictionary/app/features/bookmark/models/bookmarks.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fixture_reader.dart';
import '../helpers/mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockDio dio;
  late BookmarkRemoteDataSourceImpl dataSource;

  setUp(() {
    dio = MockDio();
    dataSource = BookmarkRemoteDataSourceImpl(dio);

    const channel = MethodChannel(
      'plugins.flutter.io/path_provider_macos',
    );
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'getApplicationDocumentsDirectory':
          return "PATH_TO_MOCK_DIR";
        default:
      }
    });
  });

  // mark & unmark word
  group('markOrUnmarkWord: ', () {
    final url = Api.baseUrl + ApiPath.markOrUnmarkWord();
    const tDictionaryId = 1;

    test('should return Bookmark when the response code is 200 (success)',
        () async {
      // arrange
      when(() => dio.post(
            url,
            data: any(named: 'data'),
            options: any(named: 'options'),
          )).thenAnswer(
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
      when(() => dio.post(
            url,
            data: any(named: 'data'),
            options: any(named: 'options'),
          )).thenThrow(ServerException());

      // act
      final call = dataSource.markOrUnmarkWord;

      // assert
      expect(() => call(tDictionaryId), throwsA(isA<ServerException>()));
    });
  });

  // get marked word
  group('getMarkedWord: ', () {
    final url = Api.baseUrl + ApiPath.getMarkedWord();
    const tDictionaryId = 1;

    test('should return Bookmark when the response code is 200 (success)',
        () async {
      // arrange
      when(() => dio.get(
            url,
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: url),
          data: jsonDecode(fixture('get_marked_word_response.json')),
          statusCode: 200,
        ),
      );

      // act
      final result = await dataSource.getMarkedWord(tDictionaryId);

      // assert
      expect(result, isA<Bookmark>());
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      // arrange
      when(() => dio.get(
            url,
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          )).thenThrow(ServerException());

      // act
      final call = dataSource.getMarkedWord;

      // assert
      expect(() => call(tDictionaryId), throwsA(isA<ServerException>()));
    });
  });

  // get bookmarked words
  group('getBookmarkedWords: ', () {
    final url = Api.baseUrl + ApiPath.getBookmarks();

    test(
        'should return List<Bookmarks> when the response code is 200 (success)',
        () async {
      // arrange
      when(() => dio.get(
            url,
            options: any(named: 'options'),
          )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: url),
          data: jsonDecode(fixture('get_bookmarked_words_response.json')),
          statusCode: 200,
        ),
      );

      // act
      final result = await dataSource.getBookmarks();

      // assert
      expect(result, isA<List<Bookmarks>>());
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      // arrange
      when(() => dio.get(
            url,
            options: any(named: 'options'),
          )).thenThrow(ServerException());

      // act
      final call = dataSource.getBookmarks;

      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });

  // delete all bookmarks
  group('deleteAllBookmarks: ', () {
    final url = Api.baseUrl + ApiPath.removeAllBookmark();

    test('should return true when the response code is 200 (success)',
        () async {
      // arrange
      when(() => dio.delete(
            url,
            options: any(named: 'options'),
          )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: url),
          data: jsonDecode(fixture('delete_all_bookmarks_response.json')),
          statusCode: 200,
        ),
      );

      // act
      final result = await dataSource.removeAllBookmark();

      // assert
      expect(result, true);
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      // arrange
      when(() => dio.delete(
            url,
            options: any(named: 'options'),
          )).thenThrow(ServerException());

      // act
      final call = dataSource.removeAllBookmark;

      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });
}
