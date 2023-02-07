import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:linkati/main.dart';

import '../ads_helper/ads_helper.dart';

class RewardedAdController extends GetxController {
  RewardedAd? _rewardedAd;
  RxBool isAdReady = false.obs;

  Rx<int?> myCoins = prefs!.getInt("coins").obs;

  void _createRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper().rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          log('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          _rewardedAd = ad;
          isAdReady(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('RewardedAd failed to load: $error');
          _rewardedAd = null;
          isAdReady(false);

          _createRewardedAd();
        },
      ),
    );
  }

  void showRewardedAd() {
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          log('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        log('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
        isAdReady(false);
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        log('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
        isAdReady(false);
      },
      onAdImpression: (RewardedAd ad) => log('$ad impression occurred.'),
    );
    if (isAdReady()) {
      _rewardedAd!.show(
          onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem) {
        // Reward the user for watching an ad.
        log("rewarded item type = ${rewardItem.type}");
        log("rewarded item amount = ${rewardItem.amount}");
        int amount = prefs!.getInt("coins")! + 3 ;
        myCoins(amount);
        prefs!.setInt("coins", amount);
        log("my coins item amount = ${prefs!.get("coins")}");
      });
    } else {
      return;
    }
  }

  @override
  void onInit() {
    _createRewardedAd();
    super.onInit();
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }
}
