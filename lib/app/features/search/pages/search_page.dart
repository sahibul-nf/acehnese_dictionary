import 'package:acehnese_dictionary/app/features/search/controllers/search_controller.dart';
import 'package:acehnese_dictionary/core/color.dart';
import 'package:acehnese_dictionary/core/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../widgets/search_input.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: SearchInput(
              textController: controller.inputController,
              hintText: "Search word",
            ),
          ),
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    SvgPicture.asset(
                      'assets/images/search-illustration.svg',
                      width: 200,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "What vocabulary are \nyou looking for?",
                      textAlign: TextAlign.center,
                      style: AppTypography.fontStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Find the right aceh language \nwords based on the keywords \nyou are looking for",
                      textAlign: TextAlign.center,
                      style: AppTypography.fontStyle(
                        color: AppColor.secondary,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
              ),
              // Obx(() {
              //   return advicesController.advices.isEmpty || search.text.isEmpty
              //       ? const SizedBox()
              //       : Container(
              //           margin: const EdgeInsets.symmetric(
              //               horizontal: 24, vertical: 4),
              //           // height: 140,
              //           padding: const EdgeInsets.all(10),
              //           decoration: BoxDecoration(
              //             color: Colors.white.withOpacity(0.8),
              //             borderRadius: BorderRadius.circular(20),
              //             boxShadow: [
              //               BoxShadow(
              //                   offset: const Offset(12, 26),
              //                   blurRadius: 50,
              //                   spreadRadius: 0,
              //                   color: Colors.grey.withOpacity(.1)),
              //             ],
              //           ),
              //           child: Column(
              //             children: [
              //               for (var item in advicesController.advices)
              //                 InkWell(
              //                   onTap: () {
              //                     search.text = item.aceh!;
              //                     // if (admobController
              //                     //     .isInterstitialAdReady.value) {
              //                     //   admobController.interstitialAd?.show();
              //                     // }
              //                     Get.to(const ARViewPage());
              //                   },
              //                   child: AdvicesCard(
              //                     textAceh: item.aceh,
              //                     textIndonesia: item.indonesia,
              //                   ),
              //                 )
              //             ],
              //           ),
              //         );
              // }),
            ],
          )
        ],
      ),
    );
  }
}
