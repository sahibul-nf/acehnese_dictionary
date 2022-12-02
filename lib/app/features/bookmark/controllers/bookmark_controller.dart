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

  Bookmark get bookmark => _bookmark.value;
  RequestState get requestState => _requestState.value;

  List<Bookmarks> get bookmarks => _bookmarks.reversed.toList();
  void addBookmark(Bookmark bookmark) {
    var bookmarks = Bookmarks();
    bookmarks.id = bookmark.id;
    bookmarks.userId = bookmark.userId;
    bookmarks.word = bookmark.word;

    _bookmarks.add(bookmarks);
  }

  void removeBookmark(int id) {
    _bookmarks.removeWhere((element) => element.id == id);
  }

  bool isBookmarked(int wordId) {
    return _bookmark.value.dictionaryId == wordId;
  }

  Future<void> getMarkedWord(int dictionaryId) async {
    _requestState.value = RequestState.Loading;
    final response = await _bookmarkRepository.getMarkedWord(dictionaryId);

    if (response.statusCode != 200) {
      _requestState.value = RequestState.Error;

      if (response.statusCode == 401) {
        Get.snackbar(
          "Opps, your session has expired.",
          "Please login again!",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
        );
      } else {
        Get.snackbar("Opps, an error occured", response.message);
      }
    } else {
      _bookmark.value = response.data ?? Bookmark();
      _requestState.value = RequestState.Loaded;
    }
  }

  // add word to bookmark
  Future<bool> addWordToBookmark(int dictionaryId) async {
    final result = await _bookmarkRepository.addWordToBookmark(dictionaryId);

    if (result.isLeft()) {
      Get.snackbar(
          "Opps, an error occured", result.fold((l) => l.message, (r) => ''));
    }

    _bookmark.value = result.fold((l) => Bookmark(), (r) => r);

    return true;
  }

  Future<void> fetchBookmarks() async {
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
