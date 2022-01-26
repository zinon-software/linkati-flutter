import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkati/src/models/user_info_model.dart';

import '../../../ads/ads_controllers/bottom_banner_ad.dart';
import '../../../controllers/form_profile_controller.dart';

class AvatarView extends StatefulWidget {
  AvatarView({Key? key, this.user}) : super(key: key);
  UserInfoModel? user;

  @override
  State<AvatarView> createState() => _AvatarViewState();
}

class _AvatarViewState extends State<AvatarView> {
  
  final FormProfileController formProfileController =
        Get.put(FormProfileController());
  String? _avatarUrl;

  @override
  Widget build(BuildContext context) {

    return Obx(
      () {
        return Scaffold(
          bottomNavigationBar: const BottomBannerAdWidget(),

          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: formProfileController.isLoading()
                ? const Align(child: CircularProgressIndicator())
                : IconButton(
                    icon: const Icon(
                      Icons.done,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      print(_avatarUrl);

                      if (_avatarUrl != null) {
                        await formProfileController.putProfile(
                            name: widget.user?.name,
                            avatar: _avatarUrl,
                            description: widget.user?.bio);
                        Get.back();
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('قم بتحديد الصورة'),
                        ));
                      }
                    },
                  ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          body: _avatarUrl != null
              ? Center(
                  child: GridTile(
                    child: Card(
                      child: Image.network(
                        (_avatarUrl!),
                      ),
                    ),
                  ),
                )
              : formProfileController.avaterList.isEmpty
                  ? const Align(child: CircularProgressIndicator())
                  : buildGredView(formProfileController.avaterList, context),
        );
      },
    );
  }

  buildGredView(List avatars, BuildContext context) {
    List<GridTile> gridTiles = [];
    avatars.forEach((post) {
      gridTiles.add(
        GridTile(
          child: Card(
            child: InkWell(
              onTap: () async {
                setState(() {
                  _avatarUrl = post.avatar;
                });
              },
              child: Image.network(
                (post.avatar),
              ),
            ),
          ),
        ),
      );
    });
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      children: gridTiles,
    );
  }
}
