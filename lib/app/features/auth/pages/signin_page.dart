import 'package:acehnese_dictionary/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../utils/color.dart';
import '../../../utils/state_enum.dart';
import '../../../widgets/app_back_button.dart';
import '../controllers/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authController = Get.find<AuthController>();

    return Scaffold(
      body: Stack(
        children: [
          const SafeArea(child: AppBackButton()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Headline text with value "Welcome Back"
              Center(
                child: Text(
                  'Hi, There\nWelcome Back',
                  style: GoogleFonts.poppins(
                    color: AppColor.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Text field filled radius 16 and prefix icon with value "Email"
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: _authController.emailLoginController,
                  cursorColor: AppColor.primary,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.secondary.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    hintStyle: GoogleFonts.poppins(
                      color: AppColor.black.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: AppColor.secondary,
                    ),
                    hintText: 'Email',
                  ),
                ),
              ),
              // Text field filled radius 16 and prefix icon with value "Password"
              const SizedBox(height: 16),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextField(
                    controller: _authController.passwordLoginController,
                    cursorColor: AppColor.primary,
                    obscureText: _authController.obsecureText,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.secondary.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      hintStyle: GoogleFonts.poppins(
                        color: AppColor.black.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: AppColor.secondary,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _authController.changeObsecureText();
                        },
                        child: Icon(
                          _authController.obsecureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColor.secondary,
                        ),
                      ),
                      hintText: 'Password',
                    ),
                  ),
                ),
              ),
              // Button filled radius 16 with value "Sign Up"
              const SizedBox(height: 30),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _authController.requestState ==
                              RequestState.Loading
                          ? null
                          : () {
                              _authController.signIn(
                                email:
                                    _authController.emailLoginController.text,
                                password: _authController
                                    .passwordLoginController.text,
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child:
                          _authController.requestState == RequestState.Loading
                              ? Center(
                                  child: LoadingAnimationWidget.prograssiveDots(
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                )
                              : Text(
                                  'Sign In',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                    ),
                  ),
                ),
              ),
              // Text with value "Not have an account?"
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'Not have an account?',
                  style: GoogleFonts.poppins(
                    color: AppColor.black.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              // Button outlined radius 16 with value "Sign In"
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Get.offNamed(AppRoutes.signup);
                    },
                    style: OutlinedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: BorderSide.none,
                    ),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                        color: AppColor.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
