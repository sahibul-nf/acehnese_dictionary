import 'package:acehnese_dictionary/app/features/dictionary/controllers/dictionary_controller.dart';
import 'package:acehnese_dictionary/app/routes/app_routes.dart';
import 'package:acehnese_dictionary/app/widgets/app_back_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:unicons/unicons.dart';

import '../../../utils/color.dart';

class WordDetailPage extends GetView<DictionaryController> {
  WordDetailPage({Key? key}) : super(key: key);

  final int wordId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // fetch word detail
    controller.fetchWordDetail(wordId);

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
                      : PageView.builder(
                          controller: controller.pageController,
                          itemCount:
                              controller.wordDetail.imagesUrl?.length ?? 0,
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              imageUrl: controller.wordDetail.imagesUrl![index],
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                              placeholder: (context, url) {
                                return Center(
                                  child:
                                      LoadingAnimationWidget.threeArchedCircle(
                                    color: AppColor.primary,
                                    size: 20,
                                  ),
                                );
                              },
                              errorWidget: (context, url, error) {
                                return const Icon(Icons.broken_image_rounded);
                              },
                            );
                          },
                        );
            },
          ),
          Align(
            alignment: const Alignment(0, 0.9),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => SmoothPageIndicator(
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 24,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(36),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () {
                          final word = controller.wordDetail;
                          return (controller.isLoadWordDetail)
                              ? const _WordDetailOnLoading()
                              : (controller.isError)
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
                                        secondaryText: word.indonesia!,
                                        primaryLanguage: "Aceh",
                                        secondaryLanguage: "Indonesia",
                                      ),
                                    );
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          // TODO: add to favorite

                          // if not login yet then show dialog
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
                                  child: const Text("Tutup"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                    Get.toNamed(AppRoutes.signin);
                                  },
                                  child: const Text("Login"),
                                ),
                              ],
                            ),
                          );

                          // if login add to favorite
                        },
                        icon: const Icon(
                          UniconsLine.bookmark,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SafeArea(child: AppBackButton()),
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
  }) : super(key: key);
  final String primaryText;
  final String primaryLanguage;
  final String secondaryText;
  final String secondaryLanguage;

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
        Text(
          secondaryLanguage,
          style: GoogleFonts.poppins(
            color: AppColor.secondary,
            fontSize: 14,
          ),
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
        height: 24,
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
        height: 24,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ]);
  }
}
