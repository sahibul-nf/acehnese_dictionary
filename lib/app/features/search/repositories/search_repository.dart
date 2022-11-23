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
        await RestApiService.get(Api.baseUrl + ApiPath.searchWord(query));

    final body = ApiResponse.fromJson(response.body);

    if (response.statusCode != 200) {
      return SearchResponse(
        message: body.meta.message,
        statusCode: response.statusCode,
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
      statusCode: response.statusCode,
      data: data,
    );
  }
}
