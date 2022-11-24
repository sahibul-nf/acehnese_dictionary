import 'package:get_storage/get_storage.dart';

class LocalStorageService {
  static final _storage = GetStorage();

  // save token to local storage with get_storage
  static void saveToken(String token) {
    _storage.write('token', token);
  }

  // get token from local storage with get_storage
  static String? getToken() {
    return _storage.read('token');
  }

  // remove token from local storage with get_storage
  static void deleteToken() {
    _storage.remove('token');
  }
}
