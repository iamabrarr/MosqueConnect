import 'dart:io';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mosqueconnect/constants/ads.dart';

class AdsController extends GetxController {
  late BannerAd bannerAd;
  late InterstitialAd interstitialAd;
  RxBool isAdLoaded = false.obs;
  RxBool isInterstitialAdLoaded = false.obs;

  initBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: Platform.isAndroid
          ? AdsConstants.androidBannerAdID
          : AdsConstants.iosBannerAdID,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          //print(error);
        },
      ),
      request: const AdRequest(),
    );

    bannerAd.load();
  }

  initInterstitialAd() {
    InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? AdsConstants.androidInterstitialAdID
          : AdsConstants.iosInterstitialAdID,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          isInterstitialAdLoaded.value = true;
          interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              isInterstitialAdLoaded.value = false;
              initInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              isInterstitialAdLoaded.value = false;
            },
          );
        },
        onAdFailedToLoad: (error) {
          interstitialAd.dispose();
        },
      ),
    );
  }

  @override
  void onInit() {
    initBannerAd();
    initInterstitialAd();
    super.onInit();
  }
}
