import 'package:acehnese_dictionary/app/utils/failure.dart';

class ErrorHandling {
  static String handleError(Failure failure) {
    final err = failure.message.toLowerCase();

    // handle any error here
    if (err.contains('email already exist')) {
      return 'Email is already registered';
    } else if (err.contains('password')) {
      return 'Password must be at least 8 characters';
    } else if (err.contains('name')) {
      return 'Name must be at least 3 characters';
    } else if (err.contains('invalid')) {
      return 'Email or password is invalid';
    } else if (err.contains('expired')) {
      return 'Session expired, please login again';
    } else if (err.contains('not found')) {
      return 'User not found';
    } else if (err.contains('connection')) {
      return 'Please check your internet connection';
    } else if (err.contains('server')) {
      return 'Server error, please try again later';
    } else if (err.contains('unauthorized')) {
      return 'Unauthorized, please login again';
    } else {
      if (err.isEmpty) {
        return 'Something went wrong, please try again later';
      }
      return err;
    }
  }
}
