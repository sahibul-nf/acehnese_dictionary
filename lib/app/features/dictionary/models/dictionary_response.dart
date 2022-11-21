import 'package:acehnese_dictionary/app/constants/api.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/get_all_words_model.dart';

class DictionaryResponse extends ApiResponseInterface {
  DictionaryResponse({
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

  final GetAllWordsModel? data;
}
