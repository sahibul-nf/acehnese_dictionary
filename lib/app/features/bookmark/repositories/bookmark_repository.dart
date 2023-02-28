import 'dart:io';

import 'package:acehnese_dictionary/app/features/bookmark/data_sources/bookmark_remote_data_source.dart';
import 'package:acehnese_dictionary/app/features/bookmark/models/bookmarks.dart';
import 'package:acehnese_dictionary/app/utils/failure.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

import '../../../constants/api.dart';
import '../../../utils/exception.dart';
import '../../../utils/services/rest_api_service.dart';
import '../models/bookmark.dart';

abstract class BookmarkRepository {
  Future<Either<Failure, Bookmark>> getMarkedWord(int dictionaryId);
  Future<Either<Failure, List<Bookmarks>>> getBookmarks();
  Future<Either<Failure, Bookmark>> markOrUnmarkWord(int dictionaryId);
  Future<Either<Failure, bool>> removeAllBookmark();
}

class BookmarkRepositoryImpl implements BookmarkRepository {
  BookmarkRepositoryImpl({required this.remoteDataSource});

  final BookmarkRemoteDataSourceImpl remoteDataSource;

  @override
  Future<Either<Failure, Bookmark>> getMarkedWord(int dictionaryId) async {
    try {
      final result = await remoteDataSource.getMarkedWord(dictionaryId);
      return Right(result);
    } on SocketException {
      return const Left(ConnectionFailure('No Internet Connection'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on UnauthorisedException {
      return const Left(UnauthorizedFailure(''));
    }
  }

  // TODO: refactor this method to use remoteDataSource
  @override
  Future<Either<Failure, List<Bookmarks>>> getBookmarks() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return const Left(ConnectionFailure('No Internet Connection'));
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
  Future<Either<Failure, Bookmark>> markOrUnmarkWord(int dictionaryId) async {
    try {
      final result = await remoteDataSource.markOrUnmarkWord(dictionaryId);
      return Right(result);
    } on SocketException {
      return const Left(ConnectionFailure('No Internet Connection'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on UnauthorisedException {
      return const Left(UnauthorizedFailure(''));
    }
  }

  // TODO: refactor this method to use remoteDataSource
  @override
  Future<Either<Failure, bool>> removeAllBookmark() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return const Left(ConnectionFailure('No Internet Connection'));
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
