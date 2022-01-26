import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../ads/ads_controllers/interstitial_ad_controller.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/profile_controller.dart';
import '../../widgets/card/card_widget.dart';
import '../../widgets/card/not_found_card.dart';
import '../../widgets/count_profile_widget.dart';
import '../../widgets/profile_widget.dart/profile_button_widget.dart';
import '../../widgets/profile_widget.dart/user_text_widget.dart';
import 'edit_avatar_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key, this.user}) : super(key: key);
  final int? user;

  @override
  Widget build(BuildContext context) {
    final ProfileController usersController = Get.put(ProfileController());
    usersController.userProfileInfo = null;
    usersController.getUserInfo(user.toString());
    usersController.userPostsList.clear();

    final color = Theme.of(context).colorScheme.primary;

    final InterstitialAdController interstitialAdController =
        Get.put(InterstitialAdController());

    return Obx(
      () {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              usersController.userProfileInfo?.id == prefs!.getInt('user_id')
                  ? IconButton(
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      onPressed: () => AuthController().signOut(),
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () => Get.back(),
                    ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 10,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    usersController.userProfileInfo?.name == null
                        ? Container(
                            height: 20,
                            width: 40,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.04),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                            ),
                          )
                        : userText(
                            text: usersController.userProfileInfo?.name,
                            paddingTop: 12.0),
                    Center(
                      child: Stack(
                        children: [
                          usersController.userProfileInfo?.avatar == null
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.04),
                                  ),
                                )
                              : ClipOval(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Ink.image(
                                      image: NetworkImage(
                                          "${usersController.userProfileInfo?.avatar}"),
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                      child: user == prefs!.getInt('user_id')
                                          ? InkWell(
                                              onTap: () {
                                                Get.to(
                                                  () => AvatarView(
                                                    user: usersController
                                                        .userProfileInfo,
                                                  ),
                                                );
                                                interstitialAdController
                                                    .showInterstitialAd();
                                              },
                                            )
                                          : InkWell(onTap: () {}),
                                    ),
                                  ),
                                ),
                          if (usersController.userProfileInfo?.id ==
                              prefs!.getInt('user_id'))
                            Positioned(
                              bottom: 0,
                              right: 4,
                              child: buildEditIcon(color),
                            ),
                        ],
                      ),
                    ),
                    usersController.userProfileInfo?.username == null
                        ? Container(
                            height: 20,
                            width: 40,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.04),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                          )
                        : userText(
                            text:
                                "${usersController.userProfileInfo?.username}@",
                            paddingTop: 4.0,
                          ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  usersController.userProfileInfo?.postCount == null
                      ? Container(
                          height: 28,
                          width: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.04),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                          ),
                        )
                      : buildCountColumn("المنشورات",
                          usersController.userProfileInfo?.postCount),
                  usersController.userProfileInfo?.followers == null
                      ? Container(
                          height: 28,
                          width: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.04),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                          ),
                        )
                      : buildCountColumn("متابعون",
                          usersController.userProfileInfo?.followers),
                  usersController.userProfileInfo?.follows == null
                      ? Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          height: 28,
                          width: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.04),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                          ),
                        )
                      : buildCountColumn(
                          "يتابع", usersController.userProfileInfo?.follows),
                ],
              ),
              (usersController.userProfileInfo == null)
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: 200.0,
                      height: 27.0,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.04),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                    )
                  : const BuildProfileButton(),
              usersController.userProfileInfo?.bio == null
                  ? Container(
                      height: 13,
                      width: 80,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.04),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                    )
                  : userText(
                      text: "${usersController.userProfileInfo?.bio}",
                      paddingTop: 2.0),
              Expanded(
                flex: 5,
                child: usersController.userPostsList.isEmpty
                    ? notFoundCard // getter not found card
                    : RefreshIndicator(
                        onRefresh: () => usersController.getUserData(
                          user.toString()),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(10),
                          itemCount: usersController.userPostsList.length,
                          itemBuilder: (context, index) => cardWidget(
                            post: usersController.userPostsList[index],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  //////////////////////////////////////

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: const Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
