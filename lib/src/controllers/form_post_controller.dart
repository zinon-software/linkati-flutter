import 'dart:developer';

import 'package:get/get.dart';
import 'package:linkati/src/models/selection_model.dart';
import 'package:linkati/src/views/home_setting.dart';

import '../../main.dart';
import '../ads/ads_controllers/rewarded_ad_controller.dart';
import '../helper/dialog_helper.dart';
import '../services/base_client.dart';
import '../services/urls.dart';
import 'base_controller.dart';

class FromPostController extends GetxController with BaseController {
  int? selection;
  var dataSelection = <SelectionModel>[].obs;

  RxBool isPost = false.obs;

  // getter selection
  int? get getSelection {
    update();
    return selection;
  }

  // setter selection
  void setSelected(newValue) {
    selection = newValue;
    update();
  }

  // get controller
  Future<void> getDataSelection() async {
    var response = await BaseClient()
        .get(
          api: SECTIONS_URL,
        )
        .catchError(handleError);
    update();

    if (response != null) {
      dataSelection.value = selectionModelFromJson(response);
    } else {
      return;
    }
  }

  // post controller
  void postData({String? titel, String? link, String? message}) async {
    int? category;
    String? dataType;

    if (isPost()) {
      dataType = "POST";
    } else {
      dataType = "GROUP";
      if (selection == null) {
        DialogHelper.showErroDialog(description: "قم ب اختيار القسم");
        return;
      }

      if (link!.length < 12) {
        DialogHelper.showErroDialog(description: 'الرابط غير صالح');
        return;
      }
      String linkSwitch = link.substring(0, 12);
      switch (linkSwitch) {
        case "https://chat":
          category = 1;
          break;
        case "https://t.me":
          category = 2;
          break;
        case "https://yout":
          category = 3;
          break;
        default:
          {
            DialogHelper.showErroDialog(description: 'الرابط غير معرف لدينا');
            return;
          }
      }
    }
    showLoading("جاري المشاركة");

    var request = {
      'titel': titel,
      'link': link,
      'message': message,
      'data_type': dataType,
      'category': category,
      'sections': selection
    };

    var response =
        await BaseClient().post(GROUPS_URL, request).catchError(handleError);
    hideLoading();
    update();

    log(response);

    if (response == null) return;

    selection = null;
    int amount = isPost() ? prefs!.getInt("coins")! - 30 : prefs!.getInt("coins")! - 1;
    RewardedAdController().myCoins(amount);
    prefs!.setInt("coins", amount);
    Get.offAll(() => HomeScreenControl());
  }

  // post controller
  putGroup(
      {required String groupID,
      String? titel,
      String? selection,
      String? category,
      String? link}) async {
    showLoading("جلب البيانات");
    var request = {
      'titel': titel,
      'link': link,
      'category': category,
      'sections': selection
    };

    var response = await BaseClient()
        .put(GROUPS_URL + groupID, request)
        .catchError(handleError);

    update();
    hideLoading();

    if (response == null) return;

    selection = null;
    Get.offAll(() => HomeScreenControl());
  }

  @override
  void onInit() {
    super.onInit();
    getDataSelection();
  }
}
