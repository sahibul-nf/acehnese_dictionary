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
  late RestApiService restApiService;

  Future<GetMarkedWordResponse> getMarkedWord(int dictionaryId);
  Future<Either<Failure, List<Bookmarks>>> getBookmarks();
}

class BookmarkRepositoryImpl implements BookmarkRepository {
  @override
  RestApiService restApiService = RestApiService();

  @override
  Future<GetMarkedWordResponse> getMarkedWord(int dictionaryId) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return GetMarkedWordResponse(
        message: 'No Internet Connection',
        statusCode: 0,
      );
    }

    final response = await restApiService.get(
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
      final response = await restApiService.get(
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
}
