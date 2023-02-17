import 'dart:io';

import 'package:acehnese_dictionary/app/features/dictionary/models/get_all_words_model.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/word.dart';
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

      test('should return ServerFailure when server is down', () async {
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
  });
}
