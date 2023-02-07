import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkati/src/views/home/search/search_view.dart';
import 'package:linkati/src/views/widgets/card/card_widget.dart';

import '../../../ads/ads_controllers/inline_banner_ad_controller.dart';
import '../../../controllers/list_post_controller.dart';
import '../../widgets/card/not_found_card.dart';
import '../form/form_post_view.dart';

class ListPostsGroupsView extends StatelessWidget {
  final String apiName;
  const ListPostsGroupsView({Key? key, required this.apiName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ListPostController postsController = Get.put(ListPostController());
    postsController.getData(apiName);
    final InlineBannerAdController inlineBannerAdController =
        Get.put(InlineBannerAdController());

    log(apiName);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const FromPostView()),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 5,
            child: Obx(
              () {
                return postsController.postOrGroupList.isEmpty
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            notFoundCard,
                            const SizedBox(
                              height: 20,
                            ),
                            TextButton(
                                onPressed: () =>
                                    postsController.getData(apiName),
                                child: const Text("تحديث")),
                            const SizedBox(
                              height: 20,
                            ),
                            TextButton(
                                onPressed: () =>
                                    Get.to(() => const SearchView()),
                                child: const Text("متابعة الناشرين"))
                          ],
                        ),
                      ) // getter not found card
                    : RefreshIndicator(
                        onRefresh: () => postsController.getData(apiName),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: postsController.postOrGroupList.length >= 3
                              ? postsController.postOrGroupList.length +
                                  (inlineBannerAdController
                                          .isInlineBannerAdLoaded()
                                      ? 1
                                      : 0)
                              : postsController.postOrGroupList.length,
                          itemBuilder: (context, index) {
                            if (inlineBannerAdController
                                    .isInlineBannerAdLoaded() &&
                                index ==
                                    inlineBannerAdController
                                        .inlineAdIndex.value) {
                              return inlineBannerAdController.getInlineBannerAd;
                            } else {
                              return cardWidget(
                                  post: postsController.postOrGroupList[
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
