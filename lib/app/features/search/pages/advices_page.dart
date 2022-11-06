import 'package:acehnese_dictionary/app/features/admob/admob_controller.dart';
import 'package:acehnese_dictionary/app/features/search/controllers/advices_controller.dart';
import 'package:acehnese_dictionary/app/features/search/pages/arview_page.dart';
import 'package:acehnese_dictionary/app/features/search/widgets/advices_card.dart';
import 'package:acehnese_dictionary/app/features/search/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:unicons/unicons.dart';

// ignore: must_be_immutable
class AdvicesPage extends StatelessWidget {
  AdvicesPage({Key? key}) : super(key: key);

  static const routeName = '/advices';

  var search = TextEditingController();

  final advicesController = Get.put(AdvicesController());
  final admobController = Get.put(AdmobController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8F9),
      // appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 24),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(12, 26),
                        blurRadius: 50,
                        spreadRadius: 0,
                        color: Colors.grey.withOpacity(.1),
                      ),
                    ],
                  ),
                  child: const Icon(
                    UniconsLine.bars,
                    color: Color(0xffB8C3DA),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Acehnese",
                style: GoogleFonts.montserrat(
                  color: const Color(0xff2C68E5),
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
              Text(
                "Dictionary",
                style: GoogleFonts.montserrat(
                  color: const Color(0xff2C68E5),
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: SearchInput(
                    textController: search, hintText: "Search word"),
              ),
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        SvgPicture.asset(
                          'assets/images/search-illustration.svg',
                          width: 200,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 280,
                          child: Text(
                            "What vocabulary are you looking for?",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: const Color(0xff2F2E41),
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 300,
                          child: Text(
                            "Find the right aceh language words \nbased on the keywords you are \nlooking for",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: const Color(0xffB8C3DA),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(() {
                          return admobController.isBannerAdReady.value
                              ? SizedBox(
                                  width: admobController.bannerAd.size.width
                                      .toDouble(),
                                  height: admobController.bannerAd.size.height
                                      .toDouble(),
                                  child: AdWidget(ad: admobController.bannerAd),
                                )
                              : const SizedBox();
                        })
                      ],
                    ),
                  ),
                  Obx(() {
                    return advicesController.advices.isEmpty ||
                            search.text.isEmpty
                        ? const SizedBox()
                        : Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 4),
                            // height: 140,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(12, 26),
                                    blurRadius: 50,
                                    spreadRadius: 0,
                                    color: Colors.grey.withOpacity(.1)),
                              ],
                            ),
                            child: Column(
                              children: [
                                for (var item in advicesController.advices)
                                  InkWell(
                                    onTap: () {
                                      search.text = item.aceh!;
                                      // if (admobController
                                      //     .isInterstitialAdReady.value) {
                                      //   admobController.interstitialAd?.show();
                                      // }
                                      Get.to(const ARViewPage());
                                    },
                                    child: AdvicesCard(
                                      textAceh: item.aceh,
                                      textIndonesia: item.indonesia,
                                    ),
                                  )
                              ],
                            ),
                          );
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
