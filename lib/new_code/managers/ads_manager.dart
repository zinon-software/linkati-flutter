import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// class AdsManager {
//   late BannerAd _bannerAd;

//   final AdRequest request = const AdRequest(
//     keywords: <String>['foo', 'bar'],
//     contentUrl: 'http://foo.com/bar.html',
//     nonPersonalizedAds: true,
//   );

//   AdsManager() {
//     MobileAds.instance.initialize();
//     _bannerAd = BannerAd(
//       adUnitId: AdHelper().bannerAdUnitId,
//       size: AdSize.banner,
//       request: request,
//       listener: BannerAdListener(onAdLoaded: (Ad ad) {
//         print('Banner Ad loaded.');
//       }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
//         print('Banner Ad failed to load: $error');
//       }),
//     );
//   }

//   void loadBannerAd() {
//     _bannerAd.load();
//   }

//   Widget getBannerAdWidget() {
//     return SizedBox(
//         height: _bannerAd.size.height.toDouble(),
//         width: _bannerAd.size.width.toDouble(),
//         child: AdWidget(ad: _bannerAd));
//   }

//   void dispose() {
//     _bannerAd.dispose();
//   }
// }

class AdsManager {
  static final AdsManager _instance = AdsManager._internal();
  factory AdsManager() => _instance;

  AdsManager._internal();

  final AdRequest request = const AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  static const int maxFailedLoadAttempts = 3;

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  RewardedInterstitialAd? _rewardedInterstitialAd;
  int _numRewardedInterstitialLoadAttempts = 0;

  late BannerAd _bannerAd;

// add banner ads
  void _createBannerAd({AdSize?  adSize}) {
    _bannerAd = BannerAd(
      adUnitId: AdHelper().bannerAdUnitId,
      size:adSize?? AdSize.banner,
      request: request,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('Banner Ad loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Banner Ad failed to load: $error');
        },
      ),
    );
    _bannerAd.load();
  }

  void loadBannerAd({AdSize? adSize}) {
    _createBannerAd(adSize:adSize);
  }

  Widget getBannerAdWidget() {
    return SizedBox(
      height: _bannerAd.size.height.toDouble(),
      width: _bannerAd.size.width.toDouble(),
      child: AdWidget(ad: _bannerAd),
    );
  }

  void disposeBannerAds() {
    _bannerAd.dispose();
  }
// end banner ads

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper().interstitialAdUnitId,
      request: request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  void _createRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper().rewardedAdUnitId,
      request: request,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print('$ad loaded.');
          _rewardedAd = ad;
          _numRewardedLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
          _rewardedAd = null;
          _numRewardedLoadAttempts += 1;
          if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
            _createRewardedAd();
          }
        },
      ),
    );
  }

  void _createRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
      // adUnitId: AdHelper().rewardedInterstitialAdUnitId,
      adUnitId: AdHelper().rewardedAdUnitId,
      request: request,
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          print('$ad loaded.');
          _rewardedInterstitialAd = ad;
          _numRewardedInterstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedInterstitialAd failed to load: $error');
          _rewardedInterstitialAd = null;
          _numRewardedInterstitialLoadAttempts += 1;
          if (_numRewardedInterstitialLoadAttempts < maxFailedLoadAttempts) {
            _createRewardedInterstitialAd();
          }
        },
      ),
    );
  }

  void loadInterstitialAd() {
    _createInterstitialAd();
  }

  void loadRewardedAd() {
    _createRewardedAd();
  }

  void loadRewardedInterstitialAd() {
    _createRewardedInterstitialAd();
  }

  void showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
      onUserEarnedReward: (Ad ad, RewardItem reward) {
        print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
      },
    );
    _rewardedAd = null;
  }

  void showRewardedInterstitialAd() {
    if (_rewardedInterstitialAd == null) {
      print('Warning: attempt to show rewarded interstitial before loaded.');
      return;
    }
    _rewardedInterstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
          print('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedInterstitialAd();
      },
      onAdFailedToShowFullScreenContent:
          (RewardedInterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedInterstitialAd();
      },
    );

    _rewardedInterstitialAd!.setImmersiveMode(true);
    _rewardedInterstitialAd!.show(
      onUserEarnedReward: (Ad ad, RewardItem reward) {
        print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
      },
    );
    _rewardedInterstitialAd = null;
  }
}

class AdHelper {
  // final bool _testMode = true;
  final bool isRelease = const bool.fromEnvironment('dart.vm.product');

  String get bannerAdUnitId {
    if (!isRelease) {
      return "ca-app-pub-3940256099942544/6300978111";
    } else if (Platform.isAndroid) {
      return "ca-app-pub-9553130506719526/7133339279";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw UnsupportedError("Unsupported Platform");
    }
  }

  String get interstitialAdUnitId {
    if (!isRelease) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else if (Platform.isAndroid) {
      return "ca-app-pub-9553130506719526/2286199091";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw UnsupportedError("Unsupported Platform");
    }
  }

  String get rewardedAdUnitId {
    if (!isRelease) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isAndroid) {
      return "ca-app-pub-9553130506719526/2587589604";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw UnsupportedError("Unsupported Platform");
    }
  }
}
