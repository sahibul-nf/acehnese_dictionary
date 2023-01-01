import 'package:acehnese_dictionary/app/widgets/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/color.dart';
import '../../../utils/state_enum.dart';
import '../controllers/auth_controller.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final _authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(top: GetPlatform.isAndroid ? 16 : 0),
                  child: const AppBackButton(
                    key: Key("back_button"),
                  ),
                ),
              ),
              // Headline text with value "Create Your Account"
              Center(
                child: Text(
                  'Create Your\nAccount',
                  style: GoogleFonts.poppins(
                    color: AppColor.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Text field filled radius 16 and prefix icon with value "Name"
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  key: const Key('nameTextField'),
                  controller: _authController.nameController,
                  cursorColor: AppColor.primary,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name cannot be empty';
                    }

                    if (value.length < 3) {
                      return 'Name must be at least 3 characters';
                    }

                    return null;
                  },
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
                      Icons.person,
                      color: AppColor.secondary,
                    ),
                    hintText: 'Name',
                    errorStyle: GoogleFonts.poppins(
                      color: AppColor.error,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              // Text field filled radius 16 and prefix icon with value "Email"
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  key: const Key('emailTextField'),
                  controller: _authController.emailController,
                  cursorColor: AppColor.primary,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email cannot be empty';
                    }

                    if (!GetUtils.isEmail(value)) {
                      return 'Email is not valid';
                    }

                    return null;
                  },
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
                    errorStyle: GoogleFonts.poppins(
                      color: AppColor.error,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              // Text field filled radius 16, prefix icon, suffix icon and obscure text with value "Password"
              const SizedBox(height: 16),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    key: const Key('passwordTextField'),
                    controller: _authController.passwordController,
                    cursorColor: AppColor.primary,
                    obscureText: _authController.obsecureText,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password cannot be empty';
                      }

                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }

                      return null;
                    },
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
                      errorStyle: GoogleFonts.poppins(
                        color: AppColor.error,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
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
                              if (_formKey.currentState!.validate()) {
                                _authController.signUp(
                                  name: _authController.nameController.text,
                                  email: _authController
                                      .emailController.text.removeAllWhitespace
                                      .toLowerCase(),
                                  password:
                                      _authController.passwordController.text,
                                );
                              }
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
                                  'Sign Up',
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
              // Text with value "Already have an account? Sign In"
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'Already have an account?',
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
                      Get.offNamed(AppRoutes.signin);
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
                      'Sign In',
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
        ),
      ),
    );
  }
}
