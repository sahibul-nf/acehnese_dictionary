import 'dart:convert';

import 'package:acehnese_dictionary/app/constants/api.dart';
import 'package:acehnese_dictionary/app/features/search/data_sources/search_remote_data_source.dart';
import 'package:acehnese_dictionary/app/features/search/models/get_recommendation_list_model.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fixture_reader.dart';
import '../helpers/mocks.dart';

void main() {
  late MockDio mockDio;
  late SearchRemoteDataSource searchRemoteDataSource;

  setUp(() {
    mockDio = MockDio();
    searchRemoteDataSource = SearchRemoteDataSource(mockDio);
  });

  group('SearchRemoteDataSource', () {
    const query = 'cicem';
    const algorithm = 'jwd';
    final url = Api.railwayBaseUrl + ApiPath.searchWord(query, algorithm);

    test('should return SearchModel when the response is 200', () async {
      // arrange
      when(() => mockDio.get(url)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: url),
            data: jsonDecode(fixture('search_response.json')),
            statusCode: 200,
          ));

      // act
      final result = await searchRemoteDataSource.search(query, algorithm);

      // assert
      expect(result, isA<List<RecommendationWordModel>>());
    });

    test('should return empty list when the response is 204', () async {
      // arrange
      when(() => mockDio.get(url)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: url),
            statusCode: 204,
          ));

      // act
      final result = await searchRemoteDataSource.search(query, algorithm);

      // assert
      expect(result, isEmpty);
    });

    test('should throw ServerException when the response is not 200 or 204',
        () async {
      // arrange
      when(() => mockDio.get(url)).thenThrow(ServerException());

      // act
      final call = searchRemoteDataSource.search(query, algorithm);

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
