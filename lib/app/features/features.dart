import 'package:acehnese_dictionary/app/features/bookmark/pages/bookmark_page.dart';
import 'package:acehnese_dictionary/app/features/profile/pages/profile_page.dart';
import 'package:acehnese_dictionary/app/features/search/pages/search_page.dart';
import 'package:acehnese_dictionary/core/color.dart';
import 'package:acehnese_dictionary/core/typography.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:unicons/unicons.dart';

import 'dictionary/pages/word_list_page.dart';

class Features extends StatefulWidget {
  const Features({Key? key}) : super(key: key);

  @override
  State<Features> createState() => _FeaturesState();
}

class _FeaturesState extends State<Features> {
  int _selectedIndex = 0;

  final feats = [
    SearchPage(),
    const WordListPage(),
    const BookmarkPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: feats[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: SalomonBottomBar(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          itemPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          unselectedItemColor: AppColor.secondary,
          items: [
            SalomonBottomBarItem(
              icon: const Icon(UniconsLine.search),
              title: Text(
                "Search",
                style: AppTypography.fontStyle(
                  height: 1.3,
                  color: AppColor.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SalomonBottomBarItem(
              icon: const Icon(UniconsLine.list_ul),
              title: Text(
                "Words",
                style: AppTypography.fontStyle(
                  height: 1.3,
                  color: AppColor.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SalomonBottomBarItem(
              icon: const Icon(UniconsLine.bookmark),
              title: Text(
                "Bookmark",
                style: AppTypography.fontStyle(
                  height: 1.3,
                  color: AppColor.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SalomonBottomBarItem(
              icon: const Icon(UniconsLine.user),
              title: Text(
                "Profile",
                style: AppTypography.fontStyle(
                  height: 1.3,
                  color: AppColor.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
