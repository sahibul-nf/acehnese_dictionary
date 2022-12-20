
import 'package:acehnese_dictionary/app/features/search/data_sources/search_remote_data_source.dart';
import 'package:acehnese_dictionary/app/features/search/repositories/search_repository.dart';
import 'package:acehnese_dictionary/app/utils/services/rest_api_service.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class MockRestApiService extends Mock implements RestApiService {}
class MockDio extends Mock implements Dio {}

class MockSearchRemoteDataSource extends Mock implements SearchRemoteDataSource {}

class MockSearchRepositoryImpl extends Mock implements SearchRepositoryImpl {}