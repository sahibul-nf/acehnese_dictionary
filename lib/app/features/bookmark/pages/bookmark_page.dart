import 'package:acehnese_dictionary/app/features/dictionary/models/word.dart';
import 'package:acehnese_dictionary/app/features/dictionary/widgets/word_card.dart';
import 'package:acehnese_dictionary/app/routes/app_routes.dart';
import 'package:acehnese_dictionary/app/utils/color.dart';
import 'package:acehnese_dictionary/app/utils/typography.dart';
import 'package:acehnese_dictionary/app/widgets/words_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../../utils/state_enum.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookmarkController());

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
      body: Obx(() {
        if (controller.requestState == RequestState.Loading) {
          return const WordsLoading();
        } else {
          return RefreshIndicator(
            color: AppColor.primary,
            onRefresh: () async => controller.getBookmarks(),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 15),
              itemCount: controller.bookmarks.length,
              itemBuilder: (context, index) {
                final Word word = controller.bookmarks[index].word!;

                return InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.wordDetail, arguments: word.id);
                  },
                  child: WordCard(
                    word: word.aceh,
                    imageUrl: word.imageUrl,
                    language: 'Aceh',
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }
}
