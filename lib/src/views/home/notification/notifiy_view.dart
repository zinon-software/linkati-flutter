import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ads/ads_controllers/inline_banner_ad_controller.dart';
import '../../../controllers/Notification_controller.dart';

class NotifiyView extends StatelessWidget {
  const NotifiyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NotificationController notifyController = Get.find();
    final InlineBannerAdController inlineBannerAdController =
        Get.put(InlineBannerAdController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 46, 45, 119),
      body: Obx(
        () {
          notifyController.showData();
          return RefreshIndicator(
            onRefresh: () => notifyController.getData(),
            child: ListView.builder(
              itemCount: (notifyController.notificationList.length >= 3) ?  notifyController.notificationList.length +
                  (inlineBannerAdController.isInlineBannerAdLoaded() ? 1 : 0) : notifyController.notificationList.length,
              itemBuilder: (context, index) {
                if (inlineBannerAdController.isInlineBannerAdLoaded() &&
                    index == inlineBannerAdController.inlineAdIndex.value) {
                  return inlineBannerAdController.getInlineBannerAd;
                } else {
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 8,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white)),
                    child: ListTile(
                      minLeadingWidth: 50,
                      leading: CircleAvatar(
                        child: ClipOval(
                          child: Image(
                            height: 50.0,
                            width: 50.0,
                            image: NetworkImage(
                                "${notifyController.notificationList[inlineBannerAdController.getListViewItemIndex(index)].sender!.avatar}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(
                        "${notifyController.notificationList[inlineBannerAdController.getListViewItemIndex(index)].action}",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
