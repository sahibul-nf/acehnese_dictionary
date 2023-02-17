import 'dart:developer';
import 'dart:io';

import 'package:acehnese_dictionary/app/constants/api.dart';
import 'package:acehnese_dictionary/app/features/dictionary/data_sources/dictionary_remote_data_source.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/dictionary_response.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/get_all_words_model.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/word_detail.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:acehnese_dictionary/app/utils/failure.dart';
import 'package:acehnese_dictionary/app/utils/services/rest_api_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

abstract class DictionaryRepository {
  Future<Either<Failure, GetAllWordsModel>> getAllWords();
  Future<GetWordDetailResponse> getWordDetail(int wordId);
}

class DictionaryRepositoryImpl implements DictionaryRepository {
  DictionaryRepositoryImpl({required this.remoteDataSource});

  final DictionaryRemoteDataSourceImpl remoteDataSource;

  @override
  Future<GetWordDetailResponse> getWordDetail(int wordId) async {
    final connectifityResult = await Connectivity().checkConnectivity();
    if (connectifityResult == ConnectivityResult.none) {
      return GetWordDetailResponse(
        message: 'No Internet Connection',
        statusCode: 0,
      );
    }

    final response =
        await RestApiService().get(Api.baseUrl + ApiPath.getWordDetail(wordId));

    final body = ApiResponse.fromJson(response.data);
    // log body meta message with key 'message, code'
    log(
      'Code: ${body.meta.code}, Message: ${body.meta.message}',
      name: 'getAllWords',
      error: body.errors,
    );

    if (response.statusCode != 200) {
      return GetWordDetailResponse(
        message: body.meta.message,
        statusCode: response.statusCode!,
        errors: body.errors.toString(),
        data: null,
      );
    }

    final data = WordDetail.fromJson(body.data);

    return GetWordDetailResponse(
      message: body.meta.message,
      statusCode: response.statusCode!,
      data: data,
    );
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
