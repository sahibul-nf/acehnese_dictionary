import 'package:acehnese_dictionary/app/constants/api.dart';
import 'package:acehnese_dictionary/app/features/bookmark/models/bookmark.dart';

class GetMarkedWordResponse extends ApiResponseInterface {
  GetMarkedWordResponse({
    required String message,
    required int statusCode,
    dynamic errors,
    this.data,
  }) : super(
          message: message,
          statusCode: statusCode,
          errors: errors,
          data: data,
        );

  final Bookmark? data;
}