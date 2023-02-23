import 'dart:io';

import 'package:acehnese_dictionary/app/features/dictionary/models/get_all_words_model.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/word.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/word_detail.dart';
import 'package:acehnese_dictionary/app/features/dictionary/repositories/dictionary_repository.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:acehnese_dictionary/app/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  late MockDictionaryRemoteDataSource mockDictionaryRemoteDataSource;
  late DictionaryRepositoryImpl dictionaryRepository;

  setUp(() {
    mockDictionaryRemoteDataSource = MockDictionaryRemoteDataSource();
    dictionaryRepository = DictionaryRepositoryImpl(
        remoteDataSource: mockDictionaryRemoteDataSource);
  });

  // test getAllWords
  final tWordModel = GetAllWordsModel(
    totalData: 1,
    words: [
      Word(
        id: 1,
        aceh: 'cicém',
        indonesia: 'burung',
        english: 'bird, fowl',
      ),
    ],
  );

  group('DictionaryRepositoryImpl', () {
    group('getAllWords', () {
      test('should return WordModelList when getAllWords successfully',
          () async {
        // arrange
        when(() => mockDictionaryRemoteDataSource.getAllWords())
            .thenAnswer((_) async => tWordModel);

        // act
        final result = await dictionaryRepository.getAllWords();

        // assert
        verify(() => mockDictionaryRemoteDataSource.getAllWords());
        final resultList =
            result.getOrElse(() => GetAllWordsModel(totalData: 0, words: []));
        expect(resultList, tWordModel);
      });

      test('should return ConnectionFailure when internet connection is lost',
          () async {
        // arrange
        when(() => mockDictionaryRemoteDataSource.getAllWords())
            .thenThrow(const SocketException('No internet connection'));

        // act
        final result = await dictionaryRepository.getAllWords();

        // assert
        verify(() => mockDictionaryRemoteDataSource.getAllWords());
        expect(result,
            equals(const Left(ConnectionFailure('No internet connection'))));
      });

      test('should return ServerFailure when server is down or error',
          () async {
        // arrange
        when(() => mockDictionaryRemoteDataSource.getAllWords())
            .thenThrow(ServerException());

        // act
        final result = await dictionaryRepository.getAllWords();

        // assert
        verify(() => mockDictionaryRemoteDataSource.getAllWords());
        expect(result, equals(const Left(ServerFailure(''))));
      });
    });

    // test getWordById
    group('getWordById', () {
      const tWordId = 1;
      final tWordDetail = WordDetail(
        id: 1,
        aceh: "yup babah",
        indonesia: "bersiul",
        english: "whistle",
        imagesUrl: [
          "https://images.unsplash.com/photo-1598284820582-b0705245e222?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzODA2NDd8MHwxfHJhbmRvbXx8fHx8fHx8fDE2NzY3NTY5Njc&ixlib=rb-4.0.3&q=80&w=1080",
          "https://images.unsplash.com/photo-1598284820665-1f2dca3fe768?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzODA2NDd8MHwxfHJhbmRvbXx8fHx8fHx8fDE2NzY3NTY5Njc&ixlib=rb-4.0.3&q=80&w=1080",
          "https://images.unsplash.com/photo-1627838879678-ce37d6b84ce0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzODA2NDd8MHwxfHJhbmRvbXx8fHx8fHx8fDE2NzY3NTY5Njc&ixlib=rb-4.0.3&q=80&w=1080"
        ],
      );

      test('should return WordDetail when getWordById successfully', () async {
        // arrange
        when(() => mockDictionaryRemoteDataSource.getWordDetail(tWordId))
            .thenAnswer((_) async => tWordDetail);

        // act
        final result = await dictionaryRepository.getWordDetail(tWordId);

        // assert
        verify(() => mockDictionaryRemoteDataSource.getWordDetail(tWordId));
        final resultDetail = result.getOrElse(() => WordDetail());
        expect(resultDetail, tWordDetail);
      });

      test('should return ConnectionFailure when internet connection is lost',
          () async {
        // arrange
        when(() => mockDictionaryRemoteDataSource.getWordDetail(tWordId))
            .thenThrow(const SocketException('No internet connection'));

        // act
        final result = await dictionaryRepository.getWordDetail(tWordId);

        // assert
        verify(() => mockDictionaryRemoteDataSource.getWordDetail(tWordId));
        expect(result,
            equals(const Left(ConnectionFailure('No internet connection'))));
      });

      test('should return ServerFailure when server is down or error', () async {
        // arrange
        when(() => mockDictionaryRemoteDataSource.getWordDetail(tWordId))
            .thenThrow(ServerException());

        // act
        final result = await dictionaryRepository.getWordDetail(tWordId);

        // assert
        verify(() => mockDictionaryRemoteDataSource.getWordDetail(tWordId));
        expect(result, equals(const Left(ServerFailure(''))));
      });
    });
  });
}
