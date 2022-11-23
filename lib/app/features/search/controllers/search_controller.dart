import 'package:acehnese_dictionary/app/features/search/models/get_recommendation_list_model.dart';
import 'package:acehnese_dictionary/app/features/search/repositories/search_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final inputController = TextEditingController();
  final _searchRepositoryImpl = SearchRepositoryImpl();
  final _isLoading = false.obs;
  final _isError = false.obs;
  final _recommendations = <RecommendationWordModel>[].obs;

  bool get isLoading => _isLoading.value;
  bool get isError => _isError.value;
  List<RecommendationWordModel> get recommendations => _recommendations;
  void resetRecommendations() => _recommendations.clear();

  void search(String query) async {
    _isLoading.value = true;
    final response = await _searchRepositoryImpl.search(query);

    if (response.statusCode == 204) {
      _recommendations.clear();

      Get.snackbar("Opps", "No data found");
    } else if (response.statusCode != 200) {
      _isError.value = response.statusCode != 200;

      Get.snackbar("Opps, an error occured", response.message);
    } else {
      _recommendations.assignAll(response.data!);
    }

    _isLoading.value = false;
  }
}
