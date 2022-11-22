import 'package:acehnese_dictionary/app/constants/api.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/dictionary_response.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/get_all_words_model.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/word_detail.dart';
import 'package:acehnese_dictionary/app/utils/services/rest_api_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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

    try {
      final response =
          await RestApiService.get(Api.baseUrl + ApiPath.getAllWords());

      final body = ApiResponse.fromJson(response.body);

      if (response.statusCode != 200) {
        return GetAllWordResponse(
          message: body.meta.message,
          statusCode: response.statusCode,
          errors: body.errors.toString(),
          data: null,
        );
      }

      final data = GetAllWordsModel.fromJson(body.data);

      return GetAllWordResponse(
        message: body.meta.message,
        statusCode: response.statusCode,
        data: data,
      );
    } catch (e) {
      return GetAllWordResponse(
        message: e.toString(),
        statusCode: 500,
        errors: e.toString(),
      );
    }
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

    try {
      final response =
          await RestApiService.get(Api.baseUrl + ApiPath.getWordDetail(wordId));

      final body = ApiResponse.fromJson(response.body);

      if (response.statusCode != 200) {
        return GetWordDetailResponse(
          message: body.meta.message,
          statusCode: response.statusCode,
          errors: body.errors.toString(),
          data: null,
        );
      }

      final data = WordDetail.fromJson(body.data);

      return GetWordDetailResponse(
        message: body.meta.message,
        statusCode: response.statusCode,
        data: data,
      );
    } catch (e) {
      return GetWordDetailResponse(
        message: e.toString(),
        statusCode: 500,
        errors: e.toString(),
      );
    }
  }
}
