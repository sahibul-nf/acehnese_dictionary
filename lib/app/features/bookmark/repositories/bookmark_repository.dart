import 'dart:developer';

import 'package:acehnese_dictionary/app/features/bookmark/models/bookmark_response.dart';
import 'package:acehnese_dictionary/app/features/bookmark/models/bookmarks.dart';
import 'package:acehnese_dictionary/app/utils/failure.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

import '../../../constants/api.dart';
import '../../../utils/services/rest_api_service.dart';
import '../models/bookmark.dart';

abstract class BookmarkRepository {
  // late RestApiService restApiService;

  Future<GetMarkedWordResponse> getMarkedWord(int dictionaryId);
  Future<Either<Failure, List<Bookmarks>>> getBookmarks();
  Future<Either<Failure, Bookmark>> addWordToBookmark(int dictionaryId);
  Future<Either<Failure, bool>> removeAllBookmark();
}

class BookmarkRepositoryImpl implements BookmarkRepository {
  // @override
  // RestApiService restApiService = RestApiService();

  @override
  Future<GetMarkedWordResponse> getMarkedWord(int dictionaryId) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return GetMarkedWordResponse(
        message: 'No Internet Connection',
        statusCode: 0,
      );
    }

    final response = await RestApiService().get(
      Api.baseUrl + ApiPath.getMarkedWord(),
      queryParameters: {
        'dictionary_id': dictionaryId,
      },
    );

    final body = ApiResponse.fromJson(response.data);
    // log body meta message with key 'message, code'
    log(
      'Code: ${body.meta.code}, Message: ${body.meta.message}',
      name: 'getAllWords',
      error: body.errors,
    );

    if (response.statusCode != 200) {
      return GetMarkedWordResponse(
        message: body.meta.message,
        statusCode: response.statusCode!,
        errors: body.errors,
        data: null,
      );
    }

    if (body.data == null) {
      return GetMarkedWordResponse(
        message: body.meta.message,
        statusCode: response.statusCode!,
        data: null,
      );
    }

    final data = Bookmark.fromJson(body.data);

    return GetMarkedWordResponse(
      message: body.meta.message,
      statusCode: response.statusCode!,
      data: data,
    );
  }

  @override
  Future<Either<Failure, List<Bookmarks>>> getBookmarks() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return Left(ConnectionFailure('No Internet Connection'));
    }

    try {
      final response = await RestApiService().get(
        Api.baseUrl + ApiPath.getBookmarks(),
      );

      if (response.statusCode != 200) {
        return Left(ServerFailure(response.data['errors']));
      }

      final data = response.data['data'];
      List<Bookmarks> bookmarks = [];

      if (data != null) {
        for (var item in data) {
          bookmarks.add(Bookmarks.fromJson(item));
        }
      }

      return Right(bookmarks);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Bookmark>> addWordToBookmark(int dictionaryId) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return Left(ConnectionFailure('No Internet Connection'));
    }

    try {
      final response = await RestApiService().postDio(
        Api.baseUrl + ApiPath.markOrUnmarkWord(),
        body: {'dictionary_id': dictionaryId},
      );

      if (response.statusCode != 200) {
        return Left(ServerFailure(response.data['errors']));
      }

      final data = response.data['data'];
      Bookmark bookmark = Bookmark();

      if (data != null) {
        bookmark = Bookmark.fromJson(data);
      }

      return Right(bookmark);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> removeAllBookmark() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return Left(ConnectionFailure('No Internet Connection'));
    }

    try {
      final response = await RestApiService().delete(
        Api.baseUrl + ApiPath.removeAllBookmark(),
      );

      if (response.statusCode != 200) {
        return Left(ServerFailure(response.data['errors']));
      }

      return const Right(true);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
