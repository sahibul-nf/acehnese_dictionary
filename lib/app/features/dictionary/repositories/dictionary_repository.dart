import 'dart:developer';

import 'package:acehnese_dictionary/app/constants/api.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/dictionary_response.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/word_detail.dart';
import 'package:acehnese_dictionary/app/utils/services/rest_api_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../models/get_all_words_model.dart';

abstract class DictionaryRepository {
  Future<GetAllWordResponse> getAllWords();
  Future<GetWordDetailResponse> getWordDetail(int wordId);
}

class DictionaryRepositoryImpl implements DictionaryRepository {
  @override
  Future<GetAllWordResponse> getAllWords() async {
    final connectifityResult = await Connectivity().checkConnectivity();
    if (connectifityResult == ConnectivityResult.none) {
      return GetAllWordResponse(
        message: 'No Internet Connection',
        statusCode: 0,
      );
    }

    final response =
        await RestApiService().get(Api.baseUrl + ApiPath.getAllWords());

    final body = ApiResponse.fromJson(response.data);
    // log body meta message with key 'message, code'
    log(
      'Code: ${body.meta.code}, Message: ${body.meta.message}',
      name: 'getAllWords',
      error: body.errors,
    );

    if (response.statusCode != 200) {
      return GetAllWordResponse(
        message: body.meta.message,
        statusCode: response.statusCode!,
        errors: body.errors.toString(),
        data: null,
      );
    }

    final data = GetAllWordsModel.fromJson(body.data);

    return GetAllWordResponse(
      message: body.meta.message,
      statusCode: response.statusCode!,
      data: data,
    );
  }

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
}
