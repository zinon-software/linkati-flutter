import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ads/ads_controllers/inline_banner_ad_controller.dart';
import '../../../controllers/form_profile_controller.dart';
import '../../../models/user_info_model.dart';

class EditProfileView extends StatefulWidget {
  EditProfileView({Key? key, this.user}) : super(key: key);
  UserInfoModel? user;

  @override
  State<EditProfileView> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileView> {
  final FormProfileController formProfileController =
      Get.put(FormProfileController());

  final InlineBannerAdController inlineBannerAdController =
      Get.put(InlineBannerAdController());

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();

    displayNameController = TextEditingController(text: widget.user?.name);
    bioController = TextEditingController(text: widget.user?.bio);
  }

  @override
  void dispose() {
    bioController.dispose();
    displayNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Center(
              child: Text(
                "Edit Profile",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            leading: formProfileController.isLoading()
                ? const Align(child: CircularProgressIndicator())
                : IconButton(
                    icon: const Icon(
                      Icons.done,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      await formProfileController.putProfile(
                          name: displayNameController.text,
                          avatar: widget.user?.avatar,
                          description: bioController.text);
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
          body: ListView(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              
               inlineBannerAdController.getInlineBannerAd, // bannar ads
              const SizedBox(
                height: 10,
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        buildDisplayNameField(),
                        buildBioField(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Column buildDisplayNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "الاسم",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: displayNameController,
          decoration: const InputDecoration(
            hintText: "Update Name",
            // errorText: _displayNameValid ? null : " Name too short",
          ),
        )
      ],
    );
  }

  Column buildBioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "الوصف",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: bioController,
          decoration: const InputDecoration(
            hintText: "Update Bio",
            // errorText: _bioValid ? null : "Bio too long",
          ),
        )
      ],
    );
  }
}
