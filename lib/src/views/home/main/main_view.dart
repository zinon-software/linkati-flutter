import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkati/src/views/home/search/search_view.dart';
import 'package:linkati/src/views/widgets/card/card_widget.dart';

import '../../../ads/ads_controllers/inline_banner_ad_controller.dart';
import '../../../controllers/post_controller.dart';
import '../../widgets/card/not_found_card.dart';
import '../../widgets/stories/stories_widget.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostController postsController = Get.find();
    final InlineBannerAdController inlineBannerAdController =
        Get.put(InlineBannerAdController());

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) => const BubbleStories(),
            ),
          ),
          Expanded(
            flex: 5,
            child: Obx(
              () {
                return postsController.postsList.isEmpty
                    ? SingleChildScrollView(
                      child: Column(
                          children: [
                            notFoundCard,
                            const SizedBox(
                              height: 20,
                            ),
                            TextButton(
                                onPressed: () => postsController.getData(),
                                child: const Text("تحديث")),
                                 const SizedBox(
                              height: 20,
                            ),
                                TextButton(
                                onPressed: () => Get.to(()=> const SearchView()),
                                child: const Text("متابعة الناشرين"))
                          ],
                        ),
                    ) // getter not found card
                    : RefreshIndicator(
                        onRefresh: () => postsController.getData(),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: postsController.postsList.length >= 3
                              ? postsController.postsList.length +
                                  (inlineBannerAdController
                                          .isInlineBannerAdLoaded()
                                      ? 1
                                      : 0)
                              : postsController.postsList.length,
                          itemBuilder: (context, index) {
                            if (inlineBannerAdController
                                    .isInlineBannerAdLoaded() &&
                                index ==
                                    inlineBannerAdController
                                        .inlineAdIndex.value) {
                              return inlineBannerAdController.getInlineBannerAd;
                            } else {
                              return cardWidget(
                                  post: postsController.postsList[
                                      inlineBannerAdController
                                          .getListViewItemIndex(index)]);
                            }
                          },
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
