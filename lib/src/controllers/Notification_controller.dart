import 'package:get/get.dart';
import '../models/notification_model.dart';
import '../services/base_client.dart';
import '../services/urls.dart';
import 'base_controller.dart';

class NotificationController extends GetxController with BaseController {
  var notificationList = <NotificationModel>[].obs; //edited line
  // getter notification count
  int get getNotifyCount => notificationList.length;
  // get controller
  Future<void> getData() async {

    var response =
        await BaseClient().get(api: NOTIFICATIONS_URL).catchError(handleError);
    update();

    if (response != null) {
      notificationList.value = notificationModelFromJson(response);
    } else {
      return;
    }
  }

  Future<void> showData() async {
    await BaseClient()
        .get(api: SHOW_NOTIFICATIONS_URL)
        .catchError(handleError);
    update();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

}
