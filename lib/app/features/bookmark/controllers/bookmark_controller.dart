import 'package:acehnese_dictionary/app/features/bookmark/repositories/bookmark_repository.dart';
import 'package:get/get.dart';

import '../../../utils/state_enum.dart';
import '../models/bookmark.dart';

class BookmarkController extends GetxController {
  final _bookmarkRepository = BookmarkRepositoryImpl();
  final _bookmarks = <Bookmark>[].obs;
  final _bookmark = Bookmark().obs;
  final _requestState = RequestState.Idle.obs;

  List<Bookmark> get bookmarks => _bookmarks;
  Bookmark get bookmark => _bookmark.value;
  RequestState get requestState => _requestState.value;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getMarkedWord(int dictionaryId) async {
    _requestState.value = RequestState.Loading;
    final response = await _bookmarkRepository.getMarkedWord(dictionaryId);

    if (response.statusCode != 200) {
      _requestState.value = RequestState.Error;
      Get.snackbar("Opps, an error occured", response.message);
    } else {
      _bookmark.value = response.data!;
      _requestState.value = RequestState.Loaded;
    }
  }
}
