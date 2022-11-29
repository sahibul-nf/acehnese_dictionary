import 'package:acehnese_dictionary/app/features/bookmark/models/bookmarks.dart';
import 'package:acehnese_dictionary/app/features/bookmark/repositories/bookmark_repository.dart';
import 'package:get/get.dart';

import '../../../utils/state_enum.dart';
import '../models/bookmark.dart';

class BookmarkController extends GetxController {
  final _bookmarkRepository = BookmarkRepositoryImpl();
  final _bookmarks = <Bookmarks>[].obs;
  final _bookmark = Bookmark().obs;
  final _requestState = RequestState.Idle.obs;

  List<Bookmarks> get bookmarks => _bookmarks;
  Bookmark get bookmark => _bookmark.value;
  RequestState get requestState => _requestState.value;

  @override
  void onInit() {
    super.onInit();

    getBookmarks();
  }

  Future<void> getMarkedWord(int dictionaryId) async {
    _requestState.value = RequestState.Loading;
    final response = await _bookmarkRepository.getMarkedWord(dictionaryId);

    if (response.statusCode != 200) {
      _requestState.value = RequestState.Error;
      Get.snackbar("Opps, an error occured", response.message);
    } else {
      _bookmark.value = response.data ?? Bookmark();
      _requestState.value = RequestState.Loaded;
    }
  }

  Future<void> getBookmarks() async {
    _requestState.value = RequestState.Loading;
    final result = await _bookmarkRepository.getBookmarks();

    result.fold(
      (failure) {
        _requestState.value = RequestState.Error;
        Get.snackbar("Opps, an error occured", failure.message);
      },
      (bookmarks) {
        _bookmarks.value = bookmarks;
        _requestState.value = RequestState.Loaded;
      },
    );
  }
}
