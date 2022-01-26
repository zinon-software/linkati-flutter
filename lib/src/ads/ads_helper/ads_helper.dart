import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  final bool _testMode = false;

  String get bannerAdUnitId {
    if (_testMode) {
      return BannerAd.testAdUnitId;
    } else if (Platform.isAndroid) {
      return "ca-app-pub-9553130506719526/7133339279";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw UnsupportedError("Unsupported Platform");
    }
  }

  String get interstitialAdUnitId {
    if (_testMode) {
      return InterstitialAd.testAdUnitId;
    } else if (Platform.isAndroid) {
      return "ca-app-pub-9553130506719526/2286199091";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw UnsupportedError("Unsupported Platform");
    }
  }

  String get rewardedAdUnitId {
    if (_testMode) {
      return RewardedAd.testAdUnitId;
    } else if (Platform.isAndroid) {
      return "ca-app-pub-9553130506719526/2587589604";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw UnsupportedError("Unsupported Platform");
    }
  }
}
