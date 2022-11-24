import 'dart:developer';

import 'package:acehnese_dictionary/app/features/bookmark/models/bookmark_response.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../constants/api.dart';
import '../../../utils/services/rest_api_service.dart';
import '../models/bookmark.dart';

abstract class BookmarkRepository {
  Future<GetMarkedWordResponse> getMarkedWord(int dictionaryId);
}

class BookmarkRepositoryImpl implements BookmarkRepository {
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
}
