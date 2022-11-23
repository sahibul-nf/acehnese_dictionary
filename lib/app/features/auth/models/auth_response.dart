import 'package:acehnese_dictionary/app/features/auth/models/auth_model.dart';

import '../../../constants/api.dart';

class AuthResponse extends ApiResponseInterface {
  AuthResponse({
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

  final AuthModel? data;
}
