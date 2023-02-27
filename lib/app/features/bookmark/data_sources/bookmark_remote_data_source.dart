import 'dart:developer';

import 'package:acehnese_dictionary/app/constants/api.dart';
import 'package:acehnese_dictionary/app/features/bookmark/models/bookmark.dart';
import 'package:acehnese_dictionary/app/features/bookmark/models/bookmarks.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:dio/dio.dart';

abstract class BookmarkRemoteDataSource {
  Future<Bookmark> getMarkedWord(int dictionaryId);
  Future<List<Bookmarks>> getBookmarks();
  Future<Bookmark> markOrUnmarkWord(int dictionaryId);
  Future<bool> removeAllBookmark();
}

class BookmarkRemoteDataSourceImpl implements BookmarkRemoteDataSource {
  late Dio dio;

  BookmarkRemoteDataSourceImpl(Dio? dio) {
    this.dio = dio ?? Dio();
  }

  @override
  Future<Bookmark> markOrUnmarkWord(int dictionaryId) async {
    try {
      final response = await dio.post(
        Api.baseUrl + ApiPath.markOrUnmarkWord(),
        data: {'dictionary_id': dictionaryId},
      );

      final body = ApiResponse.fromJson(response.data);

      log("Request POST: ${response.realUri}", name: "addWordToBookmark");
      log("Request Headers: ${response.headers}", name: "addWordToBookmark");
      log("Response: ${body.meta.message}",
          name: "addWordToBookmark", time: DateTime.now());

      return Bookmark.fromJson(body.data);
    } on DioError catch (e) {
      log("Request GET: ${e.response?.realUri}", name: "getWordDetail");
      log("Request Headers: ${e.response?.headers}", name: "getWordDetail");
      log("Response: ${e.response?.data['meta']['message']}",
          name: "getWordDetail", time: DateTime.now());

      throw ServerException();
    }
  }

  @override
  Future<List<Bookmarks>> getBookmarks() async {
    try {
      final response = await dio.get(Api.baseUrl + ApiPath.getBookmarks());

      final body = ApiResponse.fromJson(response.data);

      log("Request GET: ${response.realUri}", name: "getBookmarks");
      log("Request Headers: ${response.headers}", name: "getBookmarks");
      log("Response: ${body.meta.message}",
          name: "getBookmarks", time: DateTime.now());

      final List<Bookmarks> bookmarks = [];
      for (var item in body.data) {
        bookmarks.add(Bookmarks.fromJson(item));
      }

      return bookmarks;
    } on DioError catch (e) {
      log("Request GET: ${e.response?.realUri}", name: "getBookmarks");
      log("Request Headers: ${e.response?.headers}", name: "getBookmarks");
      log("Response: ${e.response?.data['meta']['message']}",
          name: "getBookmarks", time: DateTime.now());

      throw ServerException();
    }
  }

  @override
  Future<Bookmark> getMarkedWord(int dictionaryId) async {
    try {
      final response = await dio.get(
        Api.baseUrl + ApiPath.getMarkedWord(),
        queryParameters: {'dictionary_id': dictionaryId},
      );

      final body = ApiResponse.fromJson(response.data);

      log("Request GET: ${response.realUri}", name: "getMarkedWord");
      log("Request Headers: ${response.headers}", name: "getMarkedWord");
      log("Response: ${body.meta.message}",
          name: "getMarkedWord", time: DateTime.now());

      return Bookmark.fromJson(body.data);
    } on DioError catch (e) {
      log("Request GET: ${e.response?.realUri}", name: "getMarkedWord");
      log("Request Headers: ${e.response?.headers}", name: "getMarkedWord");
      log("Response: ${e.response?.data['meta']['message']}",
          name: "getMarkedWord", time: DateTime.now());

      throw ServerException();
    }
  }

  @override
  Future<bool> removeAllBookmark() async {
    try {
      final response =
          await dio.delete(Api.baseUrl + ApiPath.removeAllBookmark());

      final body = ApiResponse.fromJson(response.data);

      log("Request DELETE: ${response.realUri}", name: "removeAllBookmark");
      log("Request Headers: ${response.headers}", name: "removeAllBookmark");
      log("Response: ${body.meta.message}",
          name: "removeAllBookmark", time: DateTime.now());

      return response.statusCode == 200;
    } on DioError catch (e) {
      log("Request DELETE: ${e.response?.realUri}", name: "removeAllBookmark");
      log("Request Headers: ${e.response?.headers}", name: "removeAllBookmark");
      log("Response: ${e.response?.data['meta']['message']}",
          name: "removeAllBookmark", time: DateTime.now());

      throw ServerException();
    }
  }
}
