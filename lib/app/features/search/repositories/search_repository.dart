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
  // final RestApiService restApiService;
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<RecommendationWordModel>>> search(
      String query, String algorithm) async {
    try {
      // final connectifityResult = await Connectivity().checkConnectivity();
      // if (connectifityResult == ConnectivityResult.none) {
      //   return const Left(ConnectionFailure('No internet connection'));
      // }

      final result = await remoteDataSource.search(query, algorithm);

      // if (response.statusCode == 204) {
      //   return const Right([]);
      // }

      // final body = ApiResponse.fromJson(response.data);
      // log body meta message with key 'message, code'
      // log(
      //   'Code: ${body.meta.code}, Message: ${body.meta.message}',
      //   name: 'getAllWords',
      //   error: body.errors,
      // );

      // final data = body.data
      //     .map<RecommendationWordModel>(
      //         (e) => RecommendationWordModel.fromJson(e))
      //     .toList();

      return Right(result);
    } on SocketException catch (_) {
      return const Left(ConnectionFailure('No internet connection'));
    } on ServerException catch (_) {
      return const Left(ServerFailure(''));
    }
  }
}
