import 'package:acehnese_dictionary/app/features/dictionary/models/word.dart';
import 'package:acehnese_dictionary/app/features/dictionary/repositories/dictionary_repository.dart';
import 'package:get/get.dart';

class DictionaryController extends GetxController {
  final _dictionaryRepositoryImpl = DictionaryRepositoryImpl();
  final _dictionaries = <Word>[].obs;
  final _isLoading = false.obs;
  final _isError = false.obs;
  final _errorMessage = ''.obs;

  List<Word> get dictionaries => _dictionaries;
  bool get isLoading => _isLoading.value;
  bool get isError => _isError.value;
  String get errorMessage => _errorMessage.value;

  @override
  void onInit() {
    super.onInit();

    _fetchDictionary();
  }

  // Fetch all words from API
  Future<void> _fetchDictionary() async {
    _isLoading.value = true;
    final response = await _dictionaryRepositoryImpl.getAllWords();

    if (response.statusCode != 200) {
      _isError.value = response.statusCode != 200;

      Get.snackbar("Opps, an error occured", response.message);
    }

    _dictionaries.assignAll(response.data!.words);
    _isLoading.value = false;
  }
}
