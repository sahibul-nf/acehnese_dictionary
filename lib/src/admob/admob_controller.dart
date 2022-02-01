import 'package:acehnese_dictionary/src/helpers/admob_helper.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobController extends GetxController {
  late BannerAd _bannerAd;
  get bannerAd => _bannerAd;

  InterstitialAd? _interstitialAd;
  InterstitialAd? get interstitialAd => _interstitialAd;

  final _isBannerAdReady = false.obs;
  get isBannerAdReady => _isBannerAdReady;
  void setIsBannerAdReady(bool value) {
    _isBannerAdReady.value = value;
  }

  final _isInterstitialAdReady = false.obs;
  get isInterstitialAdReady => _isBannerAdReady;
  void setInterstitialAdReady(bool value) {
    _isInterstitialAdReady.value = value;
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdmobHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              // _moveToHome();
              Get.back();
            },
          );

          setInterstitialAdReady(true);
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          setInterstitialAdReady(false);
        },
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdmobHelper.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setIsBannerAdReady(true);
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          setIsBannerAdReady(false);
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );

    _bannerAd.load();
    update();
    print("success loaded Ad");
  }

  @override
  void onClose() {
    _bannerAd.dispose();
    super.onClose();
  }
}
