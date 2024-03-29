import 'package:acehnese_dictionary/app/routes/app_routes.dart';
import 'package:acehnese_dictionary/app/utils/typography.dart';
import 'package:acehnese_dictionary/app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class NoLoggedInScreen extends StatelessWidget {
  const NoLoggedInScreen({Key? key, required this.message, required this.image})
      : super(key: key);
  final String message;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(
            image,
            width: 200,
          ),
          const SizedBox(height: 70),
          Text(
            "Oopss, you are not logged in.",
            textAlign: TextAlign.center,
            style: AppTypography.fontStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTypography.fontStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 50),
          // primary button
          PrimaryButton(
            child: Text(
              'Login',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            onPressed: () {
              Get.toNamed(AppRoutes.signin);
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
