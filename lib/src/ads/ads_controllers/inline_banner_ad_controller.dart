import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../ads_helper/ads_helper.dart';



class InlineBannerAdController extends GetxController {
  final RxInt inlineAdIndex = 3.obs;

  late BannerAd _inlineBannerAd;
  final RxBool isInlineBannerAdLoaded = false.obs;

  int getListViewItemIndex(int index) {
  if (index >= inlineAdIndex.value && isInlineBannerAdLoaded()) {
    return index - 1;
  }
  return index;
}

  void _createInlineBannerAd() {
    _inlineBannerAd = BannerAd(
      size: AdSize.mediumRectangle,
      adUnitId: AdHelper().bannerAdUnitId,
      listener: BannerAdListener(onAdLoaded: (_) {
        isInlineBannerAdLoaded(true);
      }, onAdFailedToLoad: (ad, erorr) {
        ad.dispose();
      }),
      request: const AdRequest(),
    );
    _inlineBannerAd.load();
  }

  Widget get getInlineBannerAd {
    update();

    return isInlineBannerAdLoaded()
        ? Container(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      width: _inlineBannerAd.size.width.toDouble(),
      height: _inlineBannerAd.size.height.toDouble(),
      child: AdWidget(ad: _inlineBannerAd),
    )
        : Container();
  }

  @override
  void onInit() {
    _createInlineBannerAd();
    super.onInit();
  }

  @override
  void dispose() {
    _inlineBannerAd.dispose();
    super.dispose();
  }
}
