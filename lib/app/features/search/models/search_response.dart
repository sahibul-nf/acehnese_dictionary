import 'package:acehnese_dictionary/app/constants/api.dart';
import 'package:acehnese_dictionary/app/features/search/models/get_recommendation_list_model.dart';

class SearchResponse extends ApiResponseInterface {
  SearchResponse({
    required String message,
    required int statusCode,
    dynamic errors,
    this.data,
  }) : super(
          message: message,
          statusCode: statusCode,
          errors: errors,
          data: data,
        );

  final List<RecommendationWordModel>? data;
}
