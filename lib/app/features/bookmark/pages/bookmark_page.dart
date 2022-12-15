import 'package:acehnese_dictionary/app/features/auth/controllers/auth_controller.dart';
import 'package:acehnese_dictionary/app/features/bookmark/widgets/no_bookmark_items.dart';
import 'package:acehnese_dictionary/app/features/dictionary/models/word.dart';
import 'package:acehnese_dictionary/app/features/dictionary/pages/word_detail_page.dart';
import 'package:acehnese_dictionary/app/features/dictionary/widgets/word_card.dart';
import 'package:acehnese_dictionary/app/utils/color.dart';
import 'package:acehnese_dictionary/app/utils/state_enum.dart';
import 'package:acehnese_dictionary/app/utils/typography.dart';
import 'package:acehnese_dictionary/app/widgets/no_loggedin_screen.dart';
import 'package:acehnese_dictionary/app/widgets/words_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:unicons/unicons.dart';

import '../controllers/bookmark_controller.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookmarkController());
    final authController = Get.find<AuthController>();

    if (authController.authState == AuthState.login) {
      Future.delayed(Duration.zero, () => controller.fetchBookmarks());
    }

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
          Obx(() {
            if (authController.authState == AuthState.login) {
              if (controller.requestState == RequestState.Loading) {
                return const SizedBox();
              } else {
                return IconButton(
                  key: const Key('delete_all_bookmark'),
                  onPressed: _deleteAllBookmark,
                  icon: const Icon(UniconsLine.trash),
                  color: AppColor.black,
                );
              }
            }

            return const SizedBox();
          }),
          const SizedBox(width: 12),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Obx(
        () {
          if (authController.authState == AuthState.login) {
            if (controller.requestState == RequestState.Loading) {
              return WordsLoading(
                onRefresh: () async => controller.fetchBookmarks(),
              );
            } else {
              if (controller.bookmarks.isEmpty) {
                return const EmptyBookmark(
                  key: Key('empty_bookmark'),
                );
              }

              return RefreshIndicator(
                color: AppColor.primary,
                onRefresh: () async => controller.fetchBookmarks(),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemBuilder: (context, index) {
                    final Word word = controller.bookmarks[index].word!;

                    return Slidable(
                      key: Key("slidable_$index"),
                      closeOnScroll: true,
                      startActionPane: ActionPane(
                        extentRatio: 0.23,
                        motion: const ScrollMotion(),
                        children: [
                          const SizedBox(width: 20),
                          SlidableAction(
                            key: Key("slidable_action_$index"),
                            onPressed: (context) => _deleteBookmark(word.id),
                            backgroundColor: AppColor.error,
                            foregroundColor: Colors.white,
                            icon: UniconsLine.trash,
                            autoClose: true,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          // const SizedBox(width: 16),
                        ],
                      ),
                      endActionPane: ActionPane(
                        extentRatio: 0.23,
                        motion: const ScrollMotion(),
                        children: [
                          // const SizedBox(width: 16),
                          SlidableAction(
                            key: Key("slidable_action_$index"),
                            onPressed: (context) => _deleteBookmark(word.id),
                            backgroundColor: AppColor.error,
                            foregroundColor: Colors.white,
                            icon: UniconsLine.trash,
                            autoClose: true,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          // Get.toNamed(AppRoutes.wordDetail, arguments: word.id);
                          Get.to(() => WordDetailPage(), arguments: word.id);
                        },
                        child: WordCard(
                          word: word.aceh,
                          imageUrl: word.imageUrl,
                          language: 'Aceh',
                          marginVertical: 0,
                          marginHorizontal: 16,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: controller.bookmarks.length,
                ),
              );
            }
          }

          // if user not logged in yet return info text, illustration and login button
          return const NoLoggedInScreen(
            key: Key('noLoggedInScreen'),
            image: "assets/images/add-note.svg",
            message:
                "Login first to see the list of words \nthat you bookmarked.",
          );
        },
      ),
    );
  }

  void _deleteBookmark(int id) {
    final controller = Get.find<BookmarkController>();

    Get.dialog(
      AlertDialog(
        title: const Text('Delete Bookmark'),
        content: const Text('Are you sure want to delete this bookmark?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: AppTypography.fontStyle(
                color: Colors.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();

              // show loading dialog
              Get.dialog(
                Material(
                  color: Colors.transparent,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // text loading
                        Text(
                          'Wait a moment...',
                          style: AppTypography.fontStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        LoadingAnimationWidget.prograssiveDots(
                          size: 30,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                barrierDismissible: false,
              );

              Future.delayed(const Duration(seconds: 1), () {
                controller.addWordToBookmark(id).then((value) {
                  Get.back();

                  if (value) {
                    controller.fetchBookmarks();
                  }
                });
              });
            },
            child: Text(
              'Delete',
              style: AppTypography.fontStyle(
                color: AppColor.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteAllBookmark() {
    final controller = Get.find<BookmarkController>();

    Get.dialog(
      AlertDialog(
        title: const Text('Delete All Bookmark'),
        content: const Text('Are you sure want to delete all bookmark?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: AppTypography.fontStyle(
                color: Colors.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();

              // show loading dialog
              Get.dialog(
                Material(
                  color: Colors.transparent,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // text loading
                        Text(
                          'Wait a moment...',
                          style: AppTypography.fontStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        LoadingAnimationWidget.prograssiveDots(
                          size: 30,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                barrierDismissible: false,
              );

              Future.delayed(const Duration(seconds: 1), () {
                controller.removeAllBookmarks().then((value) {
                  Get.back();

                  if (value) {
                    controller.fetchBookmarks();
                  }
                });
              });
            },
            child: Text(
              'Delete',
              style: AppTypography.fontStyle(
                color: AppColor.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
