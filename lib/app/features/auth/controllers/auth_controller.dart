import 'package:acehnese_dictionary/app/features/auth/models/auth_model.dart';
import 'package:acehnese_dictionary/app/features/auth/pages/auth_check.dart';
import 'package:acehnese_dictionary/app/features/auth/respositories/auth_repository.dart';
import 'package:acehnese_dictionary/app/features/user_profile/controllers/user_controller.dart';
import 'package:acehnese_dictionary/app/features/user_profile/repositories/user_repositories.dart';
import 'package:acehnese_dictionary/app/routes/app_routes.dart';
import 'package:acehnese_dictionary/app/utils/services/local_storage_service.dart';
import 'package:acehnese_dictionary/app/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AuthState { login, logout, expired, unknown }

class AuthController extends GetxController {
  final _authRepositoryImpl = AuthRepositoryImpl();
  final _userRepositoryImpl = UserRepositoryImpl();

  final Rx<AuthModel?> _authModel = Rx<AuthModel?>(null);

  final _errorMessage = ''.obs;
  final _requestState = RequestState.Idle.obs;
  final _authState = AuthState.unknown.obs;

  AuthModel? get authModel => _authModel.value;
  void setAuthModel(AuthModel? value) => _authModel.value = value;

  String get errorMessage => _errorMessage.value;
  void setErrorMessage(String value) => _errorMessage.value = value;

  RequestState get requestState => _requestState.value;
  AuthState get authState => _authState.value;
  void setAuthState(AuthState value) => _authState.value = value;

  // Register
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  clearSignUpForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _requestState.value = RequestState.Loading;
    final result = await _authRepositoryImpl.signUp(
      name: name,
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        _requestState.value = RequestState.Error;
        _errorMessage.value = failure.message;
      },
      (data) {
        _requestState.value = RequestState.Loaded;
        clearSignUpForm();

        Get.offAllNamed(AppRoutes.signin);
      },
    );
  }

  // Login
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();

  clearSignInForm() {
    emailLoginController.clear();
    passwordLoginController.clear();
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    _requestState.value = RequestState.Loading;
    final result = await _authRepositoryImpl.signIn(
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        _requestState.value = RequestState.Error;
        Get.snackbar("Opps, an error occured", failure.message);
      },
      (data) {
        setAuthModel(data);
        _requestState.value = RequestState.Loaded;
        clearSignInForm();

        // Save token to local storage
        LocalStorageService.saveToken(data.token!);
        setAuthState(AuthState.login);

        Get.offAll(const AuthCheck());
      },
    );
  }

  // Logout
  Future<void> signOut() async {
    _requestState.value = RequestState.Loading;

    Future.delayed(const Duration(seconds: 1), () {
      _requestState.value = RequestState.Loaded;
      Get.find<UserController>().clearUser();
      setAuthModel(null);
      // Delete token from local storage
      LocalStorageService.deleteToken();

      Get.offAll(const AuthCheck());
    });
  }

  // change obsecure text
  final _obsecureText = true.obs;
  bool get obsecureText => _obsecureText.value;
  void changeObsecureText() => _obsecureText.value = !_obsecureText.value;

  // check if user is logged in
  bool checkIfUserIsLoggedIn() {
    if (_authModel.value != null) {
      return true;
    }
    return false;
  }

  Future<void> authCheck() async {
    final token = LocalStorageService.getToken();
    if (token != null) {
      final result = await _userRepositoryImpl.getUserProfile(token);

      result.fold(
        (failure) {
          setAuthModel(null);
          setAuthState(AuthState.expired);

          // Delete token from local storage
          LocalStorageService.deleteToken();

          // show snackbar
          Get.snackbar("Opps, an error occured", failure.message);
        },
        (data) {
          final _userController = Get.find<UserController>();
          _userController.setUser(data);

          setAuthModel(AuthModel(token: token));
          setAuthState(AuthState.login);
        },
      );
    } else {
      setAuthModel(null);
      setAuthState(AuthState.logout);
    }
  }

  // timer for splash screen
  void gotoHome() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(AppRoutes.feat);
    });
  }
}
