import 'package:acehnese_dictionary/app/features/search/data_sources/search_remote_data_source.dart';
import 'package:acehnese_dictionary/app/features/search/models/get_recommendation_list_model.dart';
import 'package:acehnese_dictionary/app/features/search/repositories/search_repository.dart';
import 'package:acehnese_dictionary/app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final inputController = TextEditingController();
  final _searchRepositoryImpl =
      SearchRepositoryImpl(remoteDataSource: SearchRemoteDataSource(null));
  final _isLoading = false.obs;
  final _isError = false.obs;
  final _recommendations = <RecommendationWordModel>[].obs;

  bool get isLoading => _isLoading.value;
  bool get isError => _isError.value;
  List<RecommendationWordModel> get recommendations => _recommendations;
  void resetRecommendations() {
    _recommendations.clear();
    inputController.clear();
  }

  // jaro_winkler_distance (jwd), levenshtein_distance (lev
  final isJaroWinkler = true.obs;

  String algorithmType() {
    if (isJaroWinkler.value) {
      return 'jwd';
    } else {
      return 'lev';
    }
  }

  void search(String query) async {
    _isLoading.value = true;
    final response = await _searchRepositoryImpl.search(query, algorithmType());

    response.fold(
      (l) {
        _isError.value = true;

        // show snackbar error message
        Get.snackbar(
          "Opps",
          "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColor.error,
          colorText: Colors.white,
        );
      },
      (r) {
        if (r.isEmpty) {
          _recommendations.clear();
          Get.snackbar("Opps", "No data found");
        }

        _recommendations.assignAll(r);
      },
    );

    _isLoading.value = false;
  }

  @override
  void onClose() {
    inputController.dispose();
    super.onClose();
  }
}
