import 'dart:developer';

import 'package:acehnese_dictionary/app/constants/api.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/get_all_words_model.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/word_detail.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:dio/dio.dart';

abstract class DictionaryRemoteDataSource {
  Future<GetAllWordsModel> getAllWords();
  Future<WordDetail> getWordDetail(int wordId);
}

class DictionaryRemoteDataSourceImpl extends DictionaryRemoteDataSource {
  late Dio dio;

  DictionaryRemoteDataSourceImpl(Dio? dio) {
    this.dio = dio ?? Dio();
  }

  @override
  Future<GetAllWordsModel> getAllWords() async {
    final response = await dio.get(Api.baseUrl + ApiPath.getAllWords());

    if (response.statusCode == 200) {
      final body = ApiResponse.fromJson(response.data);
      // log body meta message with key 'message, code'
      log(
        'Code: ${body.meta.code}, Message: ${body.meta.message}',
        name: 'getAllWords',
        error: body.errors,
      );

      final data = GetAllWordsModel.fromJson(body.data);
      return data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<WordDetail> getWordDetail(int wordId) async {
    try {
      final response =
          await dio.get(Api.baseUrl + ApiPath.getWordDetail(wordId));

      final body = ApiResponse.fromJson(response.data);
      // log body meta message with key 'message, code'
      log("Request GET: ${response.requestOptions.uri}", name: "getWordDetail");
      log("Request Headers: ${response.requestOptions.headers}",
          name: "getWordDetail");
      log("Response: ${response.data['meta']['message']}",
          name: "getWordDetail", time: DateTime.now());

      return WordDetail.fromJson(body.data);
    } on DioError catch (e) {
      log("Request GET: ${e.response?.realUri}", name: "getWordDetail");
      log("Request Headers: ${e.response?.headers}", name: "getWordDetail");
      log("Response: ${e.response?.data['meta']['message']}",
          name: "getWordDetail", time: DateTime.now());

      throw ServerException();
    }
  }
}
