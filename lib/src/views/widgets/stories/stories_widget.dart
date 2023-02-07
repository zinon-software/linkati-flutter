import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ads/ads_controllers/interstitial_ad_controller.dart';
import '../../home/main/list_posts_groups_view.dart';

class BubbleStories extends StatelessWidget {
  final int index;
  const BubbleStories({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InterstitialAdController interstitialAdController =
        Get.put(InterstitialAdController());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Container(
          //   width: 60,
          //   height: 60,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: Colors.black.withOpacity(0.04),
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Get.to(() => ListPostsGroupsView(
                  apiName: (index == 1) ? "groups" : "posts"));
              interstitialAdController.showInterstitialAd();
            },
            child: Container(
              // height: 30,
              // width: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.04),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              child: Text((index == 1) ? "جميع الجروبات" : "جميع المنشورات"),
            ),
          )
        ],
      ),
    );
  }
}
