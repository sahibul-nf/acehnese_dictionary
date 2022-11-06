import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../../../../core/color.dart';
import '../../../../core/typography.dart';

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
    );
  }
}
