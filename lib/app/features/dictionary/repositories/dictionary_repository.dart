import 'package:acehnese_dictionary/app/constants/api.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/dictionary_response.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/get_all_words_model.dart';
import 'package:acehnese_dictionary/app/utils/services/rest_api_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class DictionaryRepository {
  Future<DictionaryResponse> getAllWords();
}

class DictionaryRepositoryImpl implements DictionaryRepository {
  @override
  Future<DictionaryResponse> getAllWords() async {
    final connectifityResult = await Connectivity().checkConnectivity();
    if (connectifityResult == ConnectivityResult.none) {
      return DictionaryResponse(
        message: 'No Internet Connection',
        statusCode: 0,
      );
    }

    try {
      final response =
          await RestApiService.get(Api.baseUrl + ApiPath.getAllWords());

      final body = ApiResponse.fromJson(response.body);

      if (response.statusCode != 200) {
        return DictionaryResponse(
          message: body.meta.message,
          statusCode: response.statusCode,
          errors: body.errors.toString(),
          data: null,
        );
      }

      final data = GetAllWordsModel.fromJson(body.data);

      return DictionaryResponse(
        message: body.meta.message,
        statusCode: response.statusCode,
        data: data,
      );
    } catch (e) {
      return DictionaryResponse(
        message: e.toString(),
        statusCode: 500,
        errors: e.toString(),
      );
    }
  }
}
