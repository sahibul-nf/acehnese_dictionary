import 'package:acehnese_dictionary/app/routes/app_routes.dart';
import 'package:acehnese_dictionary/app/utils/services/local_storage_service.dart';
import 'package:acehnese_dictionary/app/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/auth_model.dart';
import '../respositories/auth_repository.dart';

class AuthController extends GetxController {
  final _authRepositoryImpl = AuthRepositoryImpl();
  final _authModel = AuthModel().obs;
  final _isLoadAuth = false.obs;
  final _isError = false.obs;
  final _errorMessage = ''.obs;
  final _requestState = RequestState.Idle.obs;

  AuthModel get authModel => _authModel.value;
  bool get isLoadAuth => _isLoadAuth.value;
  bool get isError => _isError.value;
  String get errorMessage => _errorMessage.value;
  RequestState get requestState => _requestState.value;

  @override
  void onInit() {
    super.onInit();
  }

  // Register
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _requestState.value = RequestState.Loading;
    final response = await _authRepositoryImpl.signUp(
      name: name,
      email: email,
      password: password,
    );

    if (response.statusCode != 200) {
      _requestState.value = RequestState.Error;
      Get.snackbar("Opps, an error occured", response.message);
    } else {
      _authModel.value = response.data!;
      _requestState.value = RequestState.Loaded;
      Get.offAndToNamed(AppRoutes.signin);
    }
  }

  // Login
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    _requestState.value = RequestState.Loading;
    final response = await _authRepositoryImpl.signIn(
      email: email,
      password: password,
    );

    if (response.statusCode != 200) {
      _requestState.value = RequestState.Error;
      Get.snackbar("Opps, an error occured", response.message);
    } else {
      _authModel.value = response.data!;
      _requestState.value = RequestState.Loaded;

      // Save token to local storage
      LocalStorageService.saveToken(_authModel.value.token!);

      Get.offAndToNamed(AppRoutes.feat);
    }
  }

  // change obsecure text
  final _obsecureText = true.obs;
  bool get obsecureText => _obsecureText.value;
  void changeObsecureText() => _obsecureText.value = !_obsecureText.value;
}
