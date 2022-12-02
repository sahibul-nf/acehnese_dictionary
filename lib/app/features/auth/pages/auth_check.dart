import 'package:acehnese_dictionary/app/features/auth/controllers/auth_controller.dart';
import 'package:acehnese_dictionary/app/features/auth/pages/splace_screen.dart';
import 'package:acehnese_dictionary/app/features/features.dart';
import 'package:acehnese_dictionary/app/features/user_profile/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UserController(), permanent: true);
    final authController = Get.put(AuthController(), permanent: true);
    Future.wait([
      Future.delayed(
        const Duration(seconds: 3),
        () => authController.authCheck(),
      ),
    ]);

    return Obx(() {
      switch (authController.authState) {
        case AuthState.login:
          return const Features();
        case AuthState.logout:
          return const Features();
        default:
          return const SplaceScreen();
      }
    });
  }
}
