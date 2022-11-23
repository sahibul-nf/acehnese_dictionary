import 'package:acehnese_dictionary/app/utils/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../../../utils/color.dart';
import '../../../utils/typography.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: AppTypography.fontStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(UniconsLine.trash),
            color: AppColor.black,
          ),
          const SizedBox(width: 12),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      // show user token in body
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Token: ${LocalStorageService.getToken() ?? 'No token'}",
            style: AppTypography.fontStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}