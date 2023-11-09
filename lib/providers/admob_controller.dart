import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobController extends GetxController {
  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;

  final bannerAd = BannerAd(
          size: AdSize.banner,
          //adUnitId: 'ca-app-pub-3940256099942544/6300978111', //!Test Id
          adUnitId: 'ca-app-pub-2123629825634884/6702037541',
          listener: const BannerAdListener(),
          request: const AdRequest())
      .obs;

  Future<void> loadBanner() async {
    await bannerAd.value.load();
    loadAd();
  }

  Future<void> loadInterstital() async {
    loadAd();
  }

//!Interstital ad Code

  /// Loads an interstitial ad.
  void loadAd() {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-2123629825634884/9569567985',
        // adUnitId: 'ca-app-pub-3940256099942544/1033173712',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (InterstitialAd ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            // Keep a reference to the ad so you can show it later.
            interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            // ignore: avoid_print
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

//!Rewarded Ad Code

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-2123629825634884/4207815697',
      // adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;
          rewardedAd?.show(onUserEarnedReward: (ad, reward) {
            // Your reward handling code here
          });
        },
        onAdFailedToLoad: (err) {
          debugPrint(err.message);
        },
      ),
    );
  }

  @override
  void onInit() async {
    super.onInit();
    await loadBanner();
    loadAd();
    loadRewardedAd();
  }

  @override
  void onClose() {
    interstitialAd
        ?.dispose(); // Dispose of the interstitial ad when it's no longer needed.
    super.onClose();
    rewardedAd?.dispose();
  }
}
