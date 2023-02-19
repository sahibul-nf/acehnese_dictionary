import 'package:acehnese_dictionary/app/features/dictionary/data_sources/dictionary_remote_data_source.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/word.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/word_detail.dart';
import 'package:acehnese_dictionary/app/features/dictionary/repositories/dictionary_repository.dart';
import 'package:acehnese_dictionary/app/utils/color.dart';
import 'package:acehnese_dictionary/app/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DictionaryController extends GetxController {
  final _dictionaryRepositoryImpl = DictionaryRepositoryImpl(
      remoteDataSource: DictionaryRemoteDataSourceImpl(null));
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

    fetchDictionaries();
  }

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }

  // Fetch all words from API
  Future<void> fetchDictionaries() async {
    _isLoadWordList.value = true;
    final response = await _dictionaryRepositoryImpl.getAllWords();

    response.fold(
      (l) {
        _isError.value = true;
        _errorMessage.value = l.message;

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
        _wordList.assignAll(r.words);
      },
    );

    _isLoadWordList.value = false;
  }

  // Fetch word detail from API
  Future<void> fetchWordDetail(int wordId) async {
    _isLoadWordDetail.value = true;
    final response = await _dictionaryRepositoryImpl.getWordDetail(wordId);

    response.fold(
      (l) {
        _isError.value = true;
        _errorMessage.value = l.message;

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
        _wordDetail.value = r;
      },
    );

    _isLoadWordDetail.value = false;
  }

  // switch language
  final _secondaryLanguage = SecondaryLanguage.Indonesia.obs;
  SecondaryLanguage get secondaryLanguage => _secondaryLanguage.value;
  void switchLanguage() {
    if (_secondaryLanguage.value == SecondaryLanguage.Indonesia) {
      _secondaryLanguage.value = SecondaryLanguage.English;
    } else {
      _secondaryLanguage.value = SecondaryLanguage.Indonesia;
    }
  }
}
