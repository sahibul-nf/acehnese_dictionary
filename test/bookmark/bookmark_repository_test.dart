import 'dart:io';

import 'package:acehnese_dictionary/app/features/bookmark/models/bookmark.dart';
import 'package:acehnese_dictionary/app/features/bookmark/models/bookmarks.dart';
import 'package:acehnese_dictionary/app/features/bookmark/repositories/bookmark_repository.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/word.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:acehnese_dictionary/app/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  late MockBookmarkRemoteDataSource mockBookmarkRemoteDataSource;
  late BookmarkRepositoryImpl bookmarkRepository;

  setUp(() {
    mockBookmarkRemoteDataSource = MockBookmarkRemoteDataSource();
    bookmarkRepository = BookmarkRepositoryImpl(
      remoteDataSource: mockBookmarkRemoteDataSource,
    );
  });

  final tBookmark = Bookmark(
    id: 105,
    dictionaryId: 1,
    userId: 20,
    word: Word(
      id: 1,
      aceh: 'cicém',
      indonesia: 'burung',
      english: 'bird, fowl',
    ),
  );

  final tBookmarks = Bookmarks(
    id: 105,
    userId: 20,
    word: Word(
      id: 1,
      aceh: 'cicém',
      indonesia: 'burung',
      english: 'bird, fowl',
    ),
  );

  final tBookmarkList = [tBookmarks];

  // getMarkedWord
  group('getMarkedWord', () {
    test('should return Bookmark when the call is successful', () async {
      // arrange
      when(() => mockBookmarkRemoteDataSource.getMarkedWord(1))
          .thenAnswer((_) async => tBookmark);
      // act
      final response = await bookmarkRepository.getMarkedWord(1);
      // assert
      verify(() => mockBookmarkRemoteDataSource.getMarkedWord(1));
      final result = response.getOrElse(() => tBookmark);
      expect(result, tBookmark);
    });

    // test connection failure
    test('should return ConnectionFailure when internet connection is lost',
        () async {
      // arrange
      when(() => mockBookmarkRemoteDataSource.getMarkedWord(1))
          .thenThrow(const SocketException('No Internet Connection'));
      // act
      final result = await bookmarkRepository.getMarkedWord(1);
      // assert
      verify(() => mockBookmarkRemoteDataSource.getMarkedWord(1));
      expect(result,
          equals(const Left(ConnectionFailure('No Internet Connection'))));
    });

    // test server failure
    test('should return ServerFailure when server is down', () async {
      // arrange
      when(() => mockBookmarkRemoteDataSource.getMarkedWord(1))
          .thenThrow(ServerException());
      // act
      final result = await bookmarkRepository.getMarkedWord(1);
      // assert
      verify(() => mockBookmarkRemoteDataSource.getMarkedWord(1));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    // test unauthorized failure
    test('should return UnauthorizedFailure when user is unauthorized',
        () async {
      // arrange
      when(() => mockBookmarkRemoteDataSource.getMarkedWord(1))
          .thenThrow(UnauthorizedException());
      // act
      final result = await bookmarkRepository.getMarkedWord(1);
      // assert
      verify(() => mockBookmarkRemoteDataSource.getMarkedWord(1));
      expect(result, equals(const Left(UnauthorizedFailure(''))));
    });
  });

  // TODO: add test for getBookmarks
  group('getBookmarks', () {
    test('should return Bookmark when the call is successful', () async {
      // arrange
      when(() => mockBookmarkRemoteDataSource.getBookmarks())
          .thenAnswer((_) async => tBookmarkList);
      // act
      final response = await bookmarkRepository.getBookmarks();
      // assert
      verify(() => mockBookmarkRemoteDataSource.getBookmarks());
      final result = response.getOrElse(() => tBookmarkList);
      expect(result, tBookmarkList);
    });

    // test connection failure
    test('should return ConnectionFailure when internet connection is lost',
        () async {
      // arrange
      when(() => mockBookmarkRemoteDataSource.getBookmarks())
          .thenThrow(const SocketException('No Internet Connection'));
      // act
      final result = await bookmarkRepository.getBookmarks();
      // assert
      verify(() => mockBookmarkRemoteDataSource.getBookmarks());
      expect(result,
          equals(const Left(ConnectionFailure('No Internet Connection'))));
    });

    // test server failure
    test('should return ServerFailure when server is down', () async {
      // arrange
      when(() => mockBookmarkRemoteDataSource.getBookmarks())
          .thenThrow(ServerException());
      // act
      final result = await bookmarkRepository.getBookmarks();
      // assert
      verify(() => mockBookmarkRemoteDataSource.getBookmarks());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    // test unauthorized failure
    test('should return UnauthorizedFailure when user is unauthorized',
        () async {
      // arrange
      when(() => mockBookmarkRemoteDataSource.getBookmarks())
          .thenThrow(UnauthorizedException());
      // act
      final result = await bookmarkRepository.getBookmarks();
      // assert
      verify(() => mockBookmarkRemoteDataSource.getBookmarks());
      expect(result, equals(const Left(UnauthorizedFailure(''))));
    });
  });

  // TODO: add test for markUnmarkWord
  group("markUnmarkWord", () {
    test('should return Bookmark when the call is successful', () async {
      // arrange
      when(() => mockBookmarkRemoteDataSource.markOrUnmarkWord(1))
          .thenAnswer((_) async => tBookmark);
      // act
      final response = await bookmarkRepository.markOrUnmarkWord(1);
      // assert
      verify(() => mockBookmarkRemoteDataSource.markOrUnmarkWord(1));
      final result = response.getOrElse(() => tBookmark);
      expect(result, tBookmark);
    });

    // test connection failure
    test('should return ConnectionFailure when internet connection is lost',
        () async {
      // arrange
      when(() => mockBookmarkRemoteDataSource.markOrUnmarkWord(1))
          .thenThrow(const SocketException('No Internet Connection'));
      // act
      final result = await bookmarkRepository.markOrUnmarkWord(1);
      // assert
      verify(() => mockBookmarkRemoteDataSource.markOrUnmarkWord(1));
      expect(result,
          equals(const Left(ConnectionFailure('No Internet Connection'))));
    });

    // test server failure
    test('should return ServerFailure when server is down', () async {
      // arrange
      when(() => mockBookmarkRemoteDataSource.markOrUnmarkWord(1))
          .thenThrow(ServerException());
      // act
      final result = await bookmarkRepository.markOrUnmarkWord(1);
      // assert
      verify(() => mockBookmarkRemoteDataSource.markOrUnmarkWord(1));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    // test unauthorized failure
    test('should return UnauthorizedFailure when user is unauthorized',
        () async {
      // arrange
      when(() => mockBookmarkRemoteDataSource.markOrUnmarkWord(1))
          .thenThrow(UnauthorizedException());
      // act
      final result = await bookmarkRepository.markOrUnmarkWord(1);
      // assert
      verify(() => mockBookmarkRemoteDataSource.markOrUnmarkWord(1));
      expect(result, equals(const Left(UnauthorizedFailure(''))));
    });
  });

  // TODO: add test for deleteAllBookmarks
  group("deleteAllBookmarks", () {
    test('should return Bookmark when the call is successful', () async {
      // arrange
      when(() => mockBookmarkRemoteDataSource.removeAllBookmark())
          .thenAnswer((_) async => true);
      // act
      final response = await bookmarkRepository.removeAllBookmark();
      // assert
      verify(() => mockBookmarkRemoteDataSource.removeAllBookmark());
      final result = response.getOrElse(() => true);
      expect(result, true);
    });

    // test connection failure
    test('should return ConnectionFailure when internet connection is lost',
        () async {
      // arrange
      when(() => mockBookmarkRemoteDataSource.removeAllBookmark())
          .thenThrow(const SocketException('No Internet Connection'));
      // act
      final result = await bookmarkRepository.removeAllBookmark();
      // assert
      verify(() => mockBookmarkRemoteDataSource.removeAllBookmark());
      expect(result,
          equals(const Left(ConnectionFailure('No Internet Connection'))));
    });

    // test server failure
    test('should return ServerFailure when server is down', () async {
      // arrange
      when(() => mockBookmarkRemoteDataSource.removeAllBookmark())
          .thenThrow(ServerException());
      // act
      final result = await bookmarkRepository.removeAllBookmark();
      // assert
      verify(() => mockBookmarkRemoteDataSource.removeAllBookmark());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    // test unauthorized failure
    test('should return UnauthorizedFailure when user is unauthorized',
        () async {
      // arrange
      when(() => mockBookmarkRemoteDataSource.removeAllBookmark())
          .thenThrow(UnauthorizedException());
      // act
      final result = await bookmarkRepository.removeAllBookmark();
      // assert
      verify(() => mockBookmarkRemoteDataSource.removeAllBookmark());
      expect(result, equals(const Left(UnauthorizedFailure(''))));
    });
  });
}
