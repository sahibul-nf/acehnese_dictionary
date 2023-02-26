import 'package:acehnese_dictionary/app/features/search/controllers/search_controller.dart';
import 'package:acehnese_dictionary/app/utils/color.dart';
import 'package:acehnese_dictionary/app/utils/typography.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../routes/app_routes.dart';
import '../widgets/advices_card.dart';
import '../widgets/search_input.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: SearchInput(
                key: const Key('search_field'),
                textController: controller.inputController,
                onChanged: (v) {
                  // check if not loading and typed something
                  if (!controller.isLoading && v.isNotEmpty) {
                    // search with delay
                    Future.delayed(const Duration(milliseconds: 700), () {
                      controller.search(v);
                    });
                  }
                },
                hintText: "Search word",
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Flexible(
                        child: SizedBox(
                          height: 120,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/images/search-illustration.svg',
                        width: MediaQuery.of(context).size.height * .25,
                      ),
                      const SizedBox(height: 30),
                      AutoSizeText(
                        "What vocabulary are \nyou looking for?",
                        textAlign: TextAlign.center,
                        style: AppTypography.fontStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      AutoSizeText(
                        "Find the right aceh language \nwords based on the keywords \nyou are looking for",
                        textAlign: TextAlign.center,
                        style: AppTypography.fontStyle(
                          color: AppColor.secondary,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // selecting button for choosing algorithm type (jaro-winkler or levenshtein)
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Jaro-Winkler",
                              style: AppTypography.fontStyle(
                                fontSize: 14,
                                color: AppColor.secondary,
                              ),
                            ),
                            Switch(
                              value: !controller.isJaroWinkler.value,
                              onChanged: (v) {
                                controller.isJaroWinkler.value = !v;
                              },
                              activeColor: AppColor.primary,
                              activeTrackColor:
                                  AppColor.primary.withOpacity(0.2),
                              inactiveThumbColor: AppColor.primary,
                              inactiveTrackColor:
                                  AppColor.primary.withOpacity(0.2),
                            ),
                            Text(
                              "Levenshtein",
                              style: AppTypography.fontStyle(
                                fontSize: 14,
                                color: AppColor.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20)
                      // Obx(() {
                      //   return admobController.isBannerAdReady.value
                      //       ? SizedBox(
                      //           width: admobController.bannerAd.size.width
                      //               .toDouble(),
                      //           height: admobController.bannerAd.size.height
                      //               .toDouble(),
                      //           child: AdWidget(ad: admobController.bannerAd),
                      //         )
                      //       : const SizedBox();
                      // })
                    ],
                  ),
                  Obx(() {
                    return controller.recommendations.isEmpty ||
                            controller.inputController.text.isEmpty
                        ? const SizedBox()
                        : Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 4),
                            // height: 140,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.7),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(12, 26),
                                    blurRadius: 50,
                                    spreadRadius: 0,
                                    color: Colors.grey.withOpacity(.1)),
                              ],
                            ),
                            child: (controller.isLoading)
                                ? SizedBox(
                                    height: 40,
                                    child: Center(
                                      child: LoadingAnimationWidget
                                          .prograssiveDots(
                                        color: AppColor.secondary ,
                                        size: 30,
                                      ),
                                    ),
                                  )
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      for (var item
                                          in controller.recommendations)
                                        InkWell(
                                          onTap: () {
                                            // set input text
                                            controller.inputController.text =
                                                item.aceh;

                                            // reset recommendations
                                            controller.resetRecommendations();

                                            // if (admobController
                                            //     .isInterstitialAdReady.value) {
                                            //   admobController.interstitialAd?.show();
                                            // }

                                            // navigate to word detail page
                                            Get.toNamed(
                                              AppRoutes.wordDetail,
                                              arguments: item.id,
                                            );
                                          },
                                          child: RecommendationCard(
                                            textAceh: item.aceh,
                                            similiarity: item.similiarity
                                                .toStringAsFixed(2),
                                          ),
                                        )
                                    ],
                                  ),
                          );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
