import 'package:acehnese_dictionary/app/features/user_profile/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final Rx<UserModel?> _user = Rx<UserModel?>(null);

  UserModel? get user => _user.value;
  void setUser(UserModel? value) => _user.value = value;

  void clearUser() {
    _user.value = null;
  }
}
