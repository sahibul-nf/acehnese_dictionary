import 'dart:convert';

import 'package:acehnese_dictionary/app/constants/api.dart';
import 'package:acehnese_dictionary/app/features/dictionary/data_sources/dictionary_remote_data_source.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/get_all_words_model.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/word_detail.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fixture_reader.dart';
import '../helpers/mocks.dart';

void main() {
  late MockDio mockDio;
  late DictionaryRemoteDataSourceImpl dictionaryRemoteDataSource;

  setUp(() {
    mockDio = MockDio();
    dictionaryRemoteDataSource = DictionaryRemoteDataSourceImpl(mockDio);
  });

  group('DictionaryRemoteDataSource', () {
    group("getAllWords", () {
      final url = Api.railwayBaseUrl + ApiPath.getAllWords();

      test('should return GetAllWordsModel when the response is 200', () async {
        // arrange
        when(() => mockDio.get(url)).thenAnswer((_) async => Response(
              requestOptions: RequestOptions(path: url),
              data: jsonDecode(fixture('dictionaries_response.json')),
              statusCode: 200,
            ));

        // act
        final result = await dictionaryRemoteDataSource.getAllWords();

        // assert
        expect(result, isA<GetAllWordsModel>());
      });

      test('should throw ServerException when the response is 404 or other',
          () async {
        // arrange
        when(() => mockDio.get(url)).thenAnswer((_) async => Response(
              requestOptions: RequestOptions(path: url),
              statusCode: 404,
            ));

        // act
        final call = dictionaryRemoteDataSource.getAllWords;

        // assert
        expect(() => call(), throwsA(isA<ServerException>()));
      });
    });
  });

  group("getWordDetail", () {
    const wordId = 1;
    final url = Api.railwayBaseUrl + ApiPath.getWordDetail(wordId);

    test('should return WordDetail when the response is 200', () async {
      // arrange
      when(() => mockDio.get(url)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: url),
            data: jsonDecode(fixture('word_detail_response.json')),
            statusCode: 200,
          ));

      // act
      final result = await dictionaryRemoteDataSource.getWordDetail(wordId);

      // assert
      expect(result, isA<WordDetail>());
    });

    test('should throw ServerException when the response is 404 or other',
        () async {
      // arrange
      when(() => mockDio.get(url)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: url),
            statusCode: 404,
          ));

      // act
      final call = dictionaryRemoteDataSource.getWordDetail;

      // assert
      expect(() => call(wordId), throwsA(isA<ServerException>()));
    });
  });
}
