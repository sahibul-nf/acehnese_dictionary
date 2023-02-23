import 'package:acehnese_dictionary/app/features/bookmark/controllers/bookmark_controller.dart';
import 'package:acehnese_dictionary/app/features/dictionary/controllers/dictionary_controller.dart';
import 'package:acehnese_dictionary/app/utils/state_enum.dart';
import 'package:acehnese_dictionary/app/utils/typography.dart';
import 'package:acehnese_dictionary/app/widgets/app_back_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:unicons/unicons.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/color.dart';
import '../../auth/controllers/auth_controller.dart';

class WordDetailPage extends GetView<DictionaryController> {
  WordDetailPage({Key? key}) : super(key: key);

  final int wordId = Get.arguments;
  final _bookmarkController = Get.put(BookmarkController());
  final _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    // fetch word detail

    controller.fetchWordDetail(wordId);
    if (_authController.checkIfUserIsLoggedIn()) {
      Future.delayed(
        Duration.zero,
        () => _bookmarkController.getMarkedWord(wordId),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // pageview full image background from network cache image
          Obx(
            () {
              return (controller.isLoadWordDetail)
                  ? Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                        color: AppColor.secondary,
                        size: 30,
                      ),
                    )
                  : (controller.isError)
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                UniconsLine.exclamation_triangle,
                                size: 50,
                                color: AppColor.secondary,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'No Data Found',
                                style: GoogleFonts.poppins(
                                  color: AppColor.secondary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      : (controller.wordDetail.imagesUrl != null)
                          ? PageView.builder(
                              key: const Key('pageview'),
                              controller: controller.pageController,
                              itemCount:
                                  controller.wordDetail.imagesUrl?.length ?? 0,
                              itemBuilder: (context, index) {
                                return CachedNetworkImage(
                                  imageUrl:
                                      controller.wordDetail.imagesUrl![index],
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                  placeholder: (context, url) {
                                    return Center(
                                      child: LoadingAnimationWidget
                                          .threeArchedCircle(
                                        color: AppColor.primary,
                                        size: 20,
                                      ),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return const Icon(
                                        Icons.broken_image_rounded);
                                  },
                                );
                              },
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    UniconsLine.image,
                                    size: 55,
                                    color: AppColor.secondary,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'No Image',
                                    style: GoogleFonts.poppins(
                                      color: AppColor.secondary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                ],
                              ),
                            );
            },
          ),
          Align(
            alignment: const Alignment(0, 0.9),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => (controller.isLoadWordDetail)
                      ? const SizedBox()
                      : SmoothPageIndicator(
                          controller: controller.pageController,
                          count: controller.wordDetail.imagesUrl?.length ?? 1,
                          effect: const ExpandingDotsEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            activeDotColor: Colors.white,
                            dotColor: Colors.grey,
                          ),
                        ),
                ),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 24,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(36),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () {
                          final word = controller.wordDetail;
                          if (controller.isLoadWordDetail) {
                            return const _WordDetailOnLoading();
                          } else {
                            return (controller.isError)
                                ? const SizedBox(
                                    height: 100,
                                    child: Center(
                                      child: Text(
                                        "No data found",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: _Word(
                                      primaryText: word.aceh!,
                                      secondaryText:
                                          controller.secondaryLanguage ==
                                                  SecondaryLanguage.Indonesia
                                              ? word.indonesia!
                                              : word.english!,
                                      primaryLanguage: "Aceh",
                                      secondaryLanguage:
                                          controller.secondaryLanguage ==
                                                  SecondaryLanguage.Indonesia
                                              ? "Indonesia"
                                              : "English",
                                      onPressed: () =>
                                          controller.switchLanguage(),
                                    ),
                                  );
                          }
                        },
                      ),
                      Obx(
                        () {
                          if (controller.isLoadWordDetail &&
                              _bookmarkController.requestState ==
                                  RequestState.Loading) {
                            return Container(
                              height: 20,
                              width: 20,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                            );
                          }

                          return LikeButton(
                            key: const Key('bookmark_button'),
                            isLiked: _bookmarkController.isBookmarked(wordId),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                isLiked
                                    ? UniconsSolid.bookmark
                                    : UniconsLine.bookmark,
                                color:
                                    isLiked ? AppColor.primary : AppColor.black,
                              );
                            },
                            circleColor: CircleColor(
                              start: Colors.white,
                              end: !Get.isDarkMode
                                  ? AppColor.primary
                                  : AppColor.secondary,
                            ),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: !Get.isDarkMode
                                  ? AppColor.primary
                                  : AppColor.secondary,
                              dotSecondaryColor: Colors.white,
                            ),
                            onTap: (isLiked) async {
                              if (_authController.checkIfUserIsLoggedIn() ==
                                  false) {
                                Get.dialog(
                                  AlertDialog(
                                    title: const Text("Opps!"),
                                    content: const Text(
                                      "You must login first to bookmark this word. Do you want to login now?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          'Close',
                                          style: AppTypography.fontStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        key: const Key("login_button"),
                                        onPressed: () {
                                          Get.back();
                                          Get.toNamed(AppRoutes.signin);
                                        },
                                        child: Text(
                                          'Login',
                                          style: AppTypography.fontStyle(
                                            color: AppColor.primary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );

                                return false;
                              } else {
                                final isMarked = await _bookmarkController
                                    .addWordToBookmark(wordId);
                                return isMarked;
                              }
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: GetPlatform.isAndroid ? 16 : 0),
              child: const AppBackButton(
                key: Key("back_button"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Word extends StatelessWidget {
  const _Word({
    Key? key,
    required this.primaryText,
    required this.secondaryText,
    required this.primaryLanguage,
    required this.secondaryLanguage,
    required this.onPressed,
  }) : super(key: key);
  final String primaryText;
  final String primaryLanguage;
  final String secondaryText;
  final String secondaryLanguage;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          primaryLanguage,
          style: GoogleFonts.poppins(
            color: AppColor.secondary,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          primaryText,
          style: GoogleFonts.poppins(
            color: AppColor.black,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Text(
              secondaryLanguage,
              style: GoogleFonts.poppins(
                color: AppColor.secondary,
                fontSize: 14,
              ),
            ),
            // switch language
            const SizedBox(width: 8),
            IconButton(
              key: const Key("switch_language_button"),
              onPressed: onPressed,
              icon: const Icon(
                UniconsLine.exchange,
                color: AppColor.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          secondaryText,
          style: GoogleFonts.poppins(
            color: AppColor.black,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}

class _WordDetailOnLoading extends StatelessWidget {
  const _WordDetailOnLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // skeleton word with shimmer effect
      Container(
        height: 16,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      const SizedBox(height: 10),
      Container(
        height: 30,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      const SizedBox(height: 20),
      Container(
        height: 16,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      const SizedBox(height: 10),
      Container(
        height: 30,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ]);
  }
}
