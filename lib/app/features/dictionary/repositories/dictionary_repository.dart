import 'dart:io';

import 'package:acehnese_dictionary/app/features/dictionary/data_sources/dictionary_remote_data_source.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/get_all_words_model.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/word_detail.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:acehnese_dictionary/app/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class DictionaryRepository {
  Future<Either<Failure, GetAllWordsModel>> getAllWords();
  Future<Either<Failure, WordDetail>> getWordDetail(int wordId);
}

class DictionaryRepositoryImpl implements DictionaryRepository {
  DictionaryRepositoryImpl({required this.remoteDataSource});

  final DictionaryRemoteDataSourceImpl remoteDataSource;

  @override
  Future<Either<Failure, WordDetail>> getWordDetail(int wordId) async {
    try {
      final response = await remoteDataSource.getWordDetail(wordId);
      return Right(response);
    } on SocketException catch (_) {
      return const Left(ConnectionFailure('No internet connection'));
    } on ServerException catch (_) {
      return const Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, GetAllWordsModel>> getAllWords() async {
    try {
      final response = await remoteDataSource.getAllWords();
      return Right(response);
    } on SocketException catch (_) {
      return const Left(ConnectionFailure('No internet connection'));
    } on ServerException catch (_) {
      return const Left(ServerFailure(''));
    }
  }
}
