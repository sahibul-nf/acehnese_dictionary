import 'package:acehnese_dictionary/app/features/bookmark/data_sources/bookmark_remote_data_source.dart';
import 'package:acehnese_dictionary/app/features/bookmark/models/bookmarks.dart';
import 'package:acehnese_dictionary/app/features/bookmark/repositories/bookmark_repository.dart';
import 'package:acehnese_dictionary/app/utils/color.dart';
import 'package:acehnese_dictionary/app/utils/error_handling.dart';
import 'package:acehnese_dictionary/app/utils/failure.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/state_enum.dart';
import '../models/bookmark.dart';

class BookmarkController extends GetxController {
  final _bookmarkRepository = BookmarkRepositoryImpl(
      remoteDataSource: BookmarkRemoteDataSourceImpl(null));
  final _bookmarks = <Bookmarks>[].obs;
  final _bookmark = Bookmark().obs;
  final _requestState = RequestState.Idle.obs;
  final _markUnmarkState = RequestState.Idle.obs;

  Bookmark get bookmark => _bookmark.value;
  RequestState get requestState => _requestState.value;
  RequestState get markUnmarkState => _markUnmarkState.value;

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
    final result = await _bookmarkRepository.getMarkedWord(dictionaryId);

    result.fold(
      (failure) {
        _requestState.value = RequestState.Error;

        if (failure is UnauthorizedFailure) {
          Get.snackbar(
            "Opps, your session has expired.",
            "Please login again!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColor.error,
            colorText: Colors.white,
            duration: const Duration(seconds: 5),
          );
        } else {
          // show snackbar error message
          Get.snackbar(
            "Opps",
            ErrorHandling.handleError(failure),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColor.error,
            colorText: Colors.white,
          );
        }
      },
      (bookmark) {
        _bookmark.value = bookmark;
        _requestState.value = RequestState.Loaded;
      },
    );
  }

  // add word to bookmark or remove from bookmark
  Future<bool> markOrUnmarkWord(int dictionaryId) async {
    _markUnmarkState.value = RequestState.Loading;
    final result = await _bookmarkRepository.markOrUnmarkWord(dictionaryId);

    result.fold(
      (failure) {
        _markUnmarkState.value = RequestState.Error;

        if (failure is UnauthorizedFailure) {
          Get.snackbar(
            "Opps, your session has expired.",
            "Please login again!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColor.error,
            colorText: Colors.white,
            duration: const Duration(seconds: 5),
          );
        } else {
          // show snackbar error message
          Get.snackbar(
            "Opps",
            ErrorHandling.handleError(failure),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColor.error,
            colorText: Colors.white,
          );
        }

        return false;
      },
      (bookmark) {
        _bookmark.value = bookmark;
        _markUnmarkState.value = RequestState.Loaded;
      },
    );

    return true;
  }

  Future<void> fetchBookmarks() async {
    _requestState.value = RequestState.Loading;
    final result = await _bookmarkRepository.getBookmarks();

    result.fold(
      (failure) {
        _requestState.value = RequestState.Error;

        // show snackbar error message
        Get.snackbar(
          "Opps",
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColor.error,
          colorText: Colors.white,
        );
      },
      (bookmarks) {
        _bookmarks.value = bookmarks;
        _requestState.value = RequestState.Loaded;
      },
    );
  }

  // remove all bookmarks
  Future<bool> removeAllBookmarks() async {
    final result = await _bookmarkRepository.removeAllBookmark();

    if (result.isLeft()) {
      // show snackbar error message
      Get.snackbar(
        "Opps",
        "Something went wrong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.error,
        colorText: Colors.white,
      );

      return false;
    }

    _bookmarks.value = [];

    return true;
  }
}
