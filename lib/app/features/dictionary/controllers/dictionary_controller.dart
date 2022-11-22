import 'package:acehnese_dictionary/app/features/dictionary/models/word.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/word_detail.dart';
import 'package:acehnese_dictionary/app/features/dictionary/repositories/dictionary_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DictionaryController extends GetxController {
  final _dictionaryRepositoryImpl = DictionaryRepositoryImpl();
  final _wordList = <Word>[].obs;
  final _wordDetail = WordDetail().obs;

  final _isLoadWordList = false.obs;
  final _isLoadWordDetail = false.obs;
  final _isError = false.obs;
  final _errorMessage = ''.obs;

  List<Word> get wordList => _wordList;
  WordDetail get wordDetail => _wordDetail.value;
  bool get isLoadWordList => _isLoadWordList.value;
  bool get isLoadWordDetail => _isLoadWordDetail.value;
  bool get isError => _isError.value;
  String get errorMessage => _errorMessage.value;

  PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();

    _fetchDictionary();
  }

  // Fetch all words from API
  Future<void> _fetchDictionary() async {
    _isLoadWordList.value = true;
    final response = await _dictionaryRepositoryImpl.getAllWords();

    if (response.statusCode != 200) {
      _isError.value = response.statusCode != 200;

      Get.snackbar("Opps, an error occured", response.message);
    }

    _wordList.assignAll(response.data!.words);
    _isLoadWordList.value = false;
  }

  // Fetch word detail from API
  Future<void> fetchWordDetail(int wordId) async {
    _isLoadWordDetail.value = true;
    final response = await _dictionaryRepositoryImpl.getWordDetail(wordId);

    if (response.statusCode != 200) {
      _isError.value = response.statusCode != 200;

      Get.snackbar("Opps, an error occured", response.message);
    }

    _wordDetail.value = response.data!;
    _isLoadWordDetail.value = false;
  }
}
