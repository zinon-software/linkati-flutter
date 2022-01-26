import 'package:get/get.dart';
import 'package:linkati/main.dart';

import '../helper/dialog_helper.dart';
import '../models/post_model.dart';
import '../models/user_info_model.dart';
import '../services/base_client.dart';
import '../services/urls.dart';
import 'base_controller.dart';

class ProfileController extends GetxController with BaseController {
  UserInfoModel? userProfileInfo;
  var userPostsList = <Posts>[].obs;

  RxBool isLoading = false.obs;

  Future<void> getUserInfo(String userID) async {
    var response = await BaseClient()
        .get(api: PROFILE_URL + userID)
        .catchError(handleError);

    if (response != null) {
      userProfileInfo = userInfoModelFromJson(response);
      update();
      getUserData(userID);
    } else {
      return;
    }
  }

  // get getUserData
  Future<void> getUserData(String userID) async {
    var response = await BaseClient()
        .get(
          api: PROFILE_GROUPS_URL + userID + "/groups",
        )
        .catchError(handleError);
    update();

    if (response != null) {
      userPostsList.value = postsFromJson(response);
    } else {
      return;
    }

    // hideLoading();
  }

  // get following
  Future<void> following(String userID) async {
    isLoading(true);

    await BaseClient()
        .get(
          api: FOLOWING_URL + userID,
        )
        .catchError(handleError);
    update();

    isLoading(false);
  }
}
