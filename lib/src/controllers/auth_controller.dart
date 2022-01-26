import 'package:linkati/src/models/auth_model.dart';
import 'package:linkati/src/views/auth_setting.dart';

import '../../main.dart';
import '../helper/dialog_helper.dart';
import '../services/base_client.dart';
import '../services/urls.dart';
import '../views/home_setting.dart';
import 'base_controller.dart';
import 'package:get/get.dart';

class AuthController extends GetxController with BaseController {
  AuthModel? dataToken; //edited line

  // post controller REGISTER
  void signUp(String username, String email, String password) async {

    showLoading("تسجيل الحساب");
    var request = {
      "username": username,
      "email": email,
      "password": password,
      "password2": password
    };

    var response =
        await BaseClient().post(REGISTER_URL, request).catchError(handleError);
    hideLoading();
    update();

    if (response == null) {
      DialogHelper.showErroDialog(description: "حدث خلل غير متوقع");
      return;
    }
    dataToken = authModelFromJson(response);
    prefs!.setString("token", dataToken!.token.toString());
    prefs!.setInt("user_id", dataToken!.id!.toInt());
    prefs!.setInt("coins", 3);
    Get.offAll(() => HomeScreenControl());
  }

  // post controller LOGIN_URL
  void signIn(String email, String password) async {
    showLoading("تسجيل الدخول");

    var request = {
      'username': email,
      'password': password,
    };

    var response =
        await BaseClient().post(LOGIN_URL, request).catchError(handleError);
    hideLoading();
    update();

    if (response == null) {
      DialogHelper.showErroDialog(description: "حدث خلل غير متوقع");
      return;
    }

    dataToken = authModelFromJson(response);
    prefs!.setString("token", dataToken!.token.toString());
    prefs!.setInt("user_id", dataToken!.id!.toInt());
    prefs!.setInt("coins", 3);
    Get.offAll(() => HomeScreenControl());
  }

  Future<void> signOut() async {

    prefs!.clear();
    // ignore: deprecated_member_use
    prefs!.commit();

    Get.offAll(() => const AuthScreenControl());
  }
}
