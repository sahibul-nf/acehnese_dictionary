import 'dart:io';

import 'package:acehnese_dictionary/app/features/search/data_sources/search_remote_data_source.dart';
import 'package:acehnese_dictionary/app/utils/exception.dart';
import 'package:acehnese_dictionary/app/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../models/get_recommendation_list_model.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<RecommendationWordModel>>> search(
      String query, String algorithm);
}

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<RecommendationWordModel>>> search(
      String query, String algorithm) async {
    try {
      final result = await remoteDataSource.search(query, algorithm);
      return Right(result);
    } on SocketException catch (_) {
      return const Left(ConnectionFailure('No internet connection'));
    } on ServerException catch (_) {
      return const Left(ServerFailure(''));
    }
  }
}
