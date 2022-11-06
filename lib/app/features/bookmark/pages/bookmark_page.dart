import 'package:acehnese_dictionary/app/features/dictionary/models/word.dart';
import 'package:acehnese_dictionary/app/features/dictionary/pages/word_list_page.dart';
import 'package:acehnese_dictionary/core/color.dart';
import 'package:acehnese_dictionary/core/typography.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bookmark',
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
      body: WordListBuilder(
        words: List.generate(
          4,
          (index) => Word(id: index, aceh: "aceh"),
        ),
        language: "Aceh",
      ),
    );
  }
}
