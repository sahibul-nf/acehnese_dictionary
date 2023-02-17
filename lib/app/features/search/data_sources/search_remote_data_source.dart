import 'dart:developer';

import 'package:acehnese_dictionary/app/constants/api.dart';
import 'package:acehnese_dictionary/app/features/search/models/get_recommendation_list_model.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:dio/dio.dart';

class SearchRemoteDataSource {
  late Dio dio;

  SearchRemoteDataSource(Dio? dio) {
    this.dio = dio ?? Dio();
  }

  Future<List<RecommendationWordModel>> search(
      String query, String algorithm) async {
    final url = Api.railwayBaseUrl + ApiPath.searchWord(query, algorithm);
    final response = await dio.get(url);

    if (response.statusCode == 204) {
      return const [];
    }

    if (response.statusCode == 200) {
      final body = ApiResponse.fromJson(response.data);
      // log body meta message with key 'message, code'
      log(
        'Code: ${body.meta.code}, Message: ${body.meta.message}',
        name: 'search',
        error: body.errors,
      );

      final data = body.data
          .map<RecommendationWordModel>(
              (e) => RecommendationWordModel.fromJson(e))
          .toList();

      return data;
    } else {
      throw ServerException();
    }
  }
}
