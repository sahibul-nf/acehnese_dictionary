import 'dart:developer';

import 'package:acehnese_dictionary/app/features/search/models/search_response.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../constants/api.dart';
import '../../../utils/services/rest_api_service.dart';
import '../models/get_recommendation_list_model.dart';

abstract class SearchRepository {
  Future<SearchResponse> search(String query);
}

class SearchRepositoryImpl implements SearchRepository {
  @override
  Future<SearchResponse> search(String query) async {
    final connectifityResult = await Connectivity().checkConnectivity();
    if (connectifityResult == ConnectivityResult.none) {
      return SearchResponse(
        message: 'No Internet Connection',
        statusCode: 0,
      );
    }

    final response =
        await RestApiService().get(Api.baseUrl + ApiPath.searchWord(query));

    if (response.statusCode == 204) {
      return SearchResponse(
        message: response.statusMessage!,
        statusCode: response.statusCode!,
        errors: null,
        data: null,
      );
    }

    final body = ApiResponse.fromJson(response.data);
    // log body meta message with key 'message, code'
    log(
      'Code: ${body.meta.code}, Message: ${body.meta.message}',
      name: 'getAllWords',
      error: body.errors,
    );

    if (response.statusCode != 200) {
      return SearchResponse(
        message: body.meta.message,
        statusCode: body.meta.code,
        errors: body.errors.toString(),
        data: null,
      );
    }

    final data = body.data
        .map<RecommendationWordModel>(
            (e) => RecommendationWordModel.fromJson(e))
        .toList();

    return SearchResponse(
      message: body.meta.message,
      statusCode: response.statusCode!,
      data: data,
    );
  }
}
