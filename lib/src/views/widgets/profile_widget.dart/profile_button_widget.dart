import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkati/src/views/home/profile/edit_profile_view.dart';

import '../../../../main.dart';
import '../../../controllers/profile_controller.dart';

class BuildProfileButton extends StatefulWidget {
  const BuildProfileButton({Key? key}) : super(key: key);

  @override
  _BuildProfileButtonState createState() => _BuildProfileButtonState();
}

class _BuildProfileButtonState extends State<BuildProfileButton> {
  final ProfileController userController = Get.put(ProfileController());

  bool isFollowing = false;

  bool isProfileOwner = false;

  int? userID;

  @override
  void initState() {
    super.initState();
    isFollowing = userController.userProfileInfo!.isFollowing!;
    isProfileOwner =
        userController.userProfileInfo?.id == prefs!.getInt('user_id');
    userID = userController.userProfileInfo?.id;
    print(isProfileOwner);
  }

  @override
  Widget build(BuildContext context) {
    if (isProfileOwner) {
      return buildButton(
        text: "تعديل الملف الشخصي",
        function: editProfile,
      );
    } else if (isFollowing) {
      return buildButton(
        text: "الغاء المتابعة",
        function: handleUnfollowUser,
      );
    } else {
      return buildButton(
        text: "متابعة",
        function: handleFollowUser,
      );
    }
  }

  Container buildButton({String? text, function}) {
    return Container(
      padding: const EdgeInsets.only(top: 2.0),
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: function,
        child: Obx(
          () {
            return Container(
              width: 200.0,
              height: 27.0,
              child: userController.isLoading()
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    )
                  : Text(
                      text!,
                      style: TextStyle(
                        color: isFollowing ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isFollowing ? Colors.white : Colors.blue,
                border: Border.all(
                  color: isFollowing ? Colors.grey : Colors.blue,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
            );
          },
        ),
      ),
    );
  }

  editProfile() {
    Get.to(
      () => EditProfileView(
        user: userController.userProfileInfo,
      ),
    );
  }

  handleUnfollowUser() {
    userController.following(userID.toString());
    setState(() {
      isFollowing = false;
    });
    // remove follower
  }

  handleFollowUser() {
    userController.following(userID.toString());
    setState(() {
      isFollowing = true;
    });
  }
}
