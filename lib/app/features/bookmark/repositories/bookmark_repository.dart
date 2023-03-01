import 'dart:io';

import 'package:acehnese_dictionary/app/features/bookmark/data_sources/bookmark_remote_data_source.dart';
import 'package:acehnese_dictionary/app/features/bookmark/models/bookmarks.dart';
import 'package:acehnese_dictionary/app/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../utils/exception.dart';
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

  @override
  Future<Either<Failure, List<Bookmarks>>> getBookmarks() async {
    try {
      final result = await remoteDataSource.getBookmarks();
      return Right(result);
    } on SocketException {
      return const Left(ConnectionFailure('No Internet Connection'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on UnauthorisedException {
      return const Left(UnauthorizedFailure(''));
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

  @override
  Future<Either<Failure, bool>> removeAllBookmark() async {
    try {
      final result = await remoteDataSource.removeAllBookmark();
      return Right(result);
    } on SocketException {
      return const Left(ConnectionFailure('No Internet Connection'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on UnauthorisedException {
      return const Left(UnauthorizedFailure(''));
    }
  }
}
