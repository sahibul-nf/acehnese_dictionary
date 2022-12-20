import 'dart:io';

import 'package:acehnese_dictionary/app/features/search/models/get_recommendation_list_model.dart';
import 'package:acehnese_dictionary/app/features/search/repositories/search_repository.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:acehnese_dictionary/app/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  late MockSearchRemoteDataSource mockSearchRemoteDataSource;
  late SearchRepositoryImpl searchRepository;

  setUp(() {
    mockSearchRemoteDataSource = MockSearchRemoteDataSource();
    searchRepository =
        SearchRepositoryImpl(remoteDataSource: mockSearchRemoteDataSource);
  });

  final tRecommendationWordModel = RecommendationWordModel(
    id: 5093,
    aceh: 'cicém',
    indonesia: 'burung',
    english: 'bird, fowl',
    similiarity: 0.9066666666666667,
  );

  final tRecommendationWordModelList = [
    tRecommendationWordModel,
  ];

  group('SearchRepositoryImpl', () {
    group('search', () {
      const query = 'cicem';
      const algorithm = 'jwd';

      test('should return SearchModel when search successfully', () async {
        // arrange
        when(() => mockSearchRemoteDataSource.search(query, algorithm))
            .thenAnswer((_) async => tRecommendationWordModelList);

        // act
        final result = await searchRepository.search(query, algorithm);

        // assert
        verify(() => mockSearchRemoteDataSource.search(query, algorithm));
        final resultList = result.getOrElse(() => []);
        expect(resultList, tRecommendationWordModelList);
      });

      test('should return ConnectionFailure when internet connection is lost',
          () async {
        // arrange
        when(() => mockSearchRemoteDataSource.search(query, algorithm))
            .thenThrow(const SocketException('No internet connection'));

        // act
        final result = await searchRepository.search(query, algorithm);

        // assert
        verify(() => mockSearchRemoteDataSource.search(query, algorithm));
        expect(result,
            equals(const Left(ConnectionFailure('No internet connection'))));
      });

      test('should throw ServerFailure when server error occurs', () async {
        // arrange
        when(() => mockSearchRemoteDataSource.search(query, algorithm))
            .thenThrow(ServerException());

        // act
        final result = await searchRepository.search(query, algorithm);

        // assert
        verify(() => mockSearchRemoteDataSource.search(query, algorithm));
        expect(result, equals(const Left(ServerFailure(''))));
      });
    });
  });
}
