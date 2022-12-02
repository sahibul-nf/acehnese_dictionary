import 'package:acehnese_dictionary/app/utils/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyBookmark extends StatelessWidget {
  const EmptyBookmark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/empty_bookmark.svg',
            width: 250,
          ),
          const SizedBox(height: 70),
          Text(
            "Oopss, you don't have \nany bookmark.",
            textAlign: TextAlign.center,
            style: AppTypography.fontStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "You can bookmark your \nfavorite words and save them \nin your account.",
            textAlign: TextAlign.center,
            style: AppTypography.fontStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
