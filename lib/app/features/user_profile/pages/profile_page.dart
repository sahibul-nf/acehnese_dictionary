import 'package:acehnese_dictionary/app/features/user_profile/controllers/user_controller.dart';
import 'package:acehnese_dictionary/app/utils/color.dart';
import 'package:acehnese_dictionary/app/utils/state_enum.dart';
import 'package:acehnese_dictionary/app/widgets/no_loggedin_screen.dart';
import 'package:acehnese_dictionary/app/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/typography.dart';
import '../../auth/controllers/auth_controller.dart';

class ProfilePage extends GetView<UserController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final user = controller.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: AppTypography.fontStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(UniconsLine.trash),
        //     color: AppColor.black,
        //   ),
        //   const SizedBox(width: 12),
        // ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      // show user token in body
      body: Obx(() {
        final avatarUrl = user?.avatarUrl ?? '';
        final name = user?.name ?? '';
        final email = user?.email ?? '';

        if (authController.authState == AuthState.login) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // avatar image
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey[200],
                  child: avatarUrl.isNotEmpty
                      ? Image.network(avatarUrl)
                      : const Icon(
                          Icons.person,
                          size: 55,
                          color: Colors.grey,
                        ),
                ),
                const SizedBox(height: 40),
                // user name
                Text(
                  name,
                  style: AppTypography.fontStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                // user email
                Text(
                  email,
                  style: AppTypography.fontStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // logout button
                const Spacer(),
                Obx(
                  () => SecondaryButton(
                    text: (authController.requestState == RequestState.Loading)
                        ? "Wait a moment..."
                        : "Sign Out",
                    onPressed:
                        (authController.requestState == RequestState.Loading)
                            ? null
                            : () => authController.signOut(),
                    textColor: AppColor.error,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        }

        return const NoLoggedInScreen(
          message: "Please login to see your profile. \nThank you.",
          image: "assets/images/profile.svg",
        );
      }),
    );
  }
}
