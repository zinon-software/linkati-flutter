import '../models/post_model.dart';
import '../services/base_client.dart';
import '../services/urls.dart';
import 'base_controller.dart';
import 'package:get/get.dart';

class AdminController extends GetxController with BaseController {
  var adminPostsList = <Posts>[].obs;
  RxBool isLoading = false.obs;

  // get controller
  Future<void> getData() async {

    var response = await BaseClient()
        .get(
          api: ADMIN_URL,
        )
        .catchError(handleError);
    update();

    if (response != null) {
      adminPostsList.value = postsFromJson(response);
    } else {
      return;
    }
    
  }

  // share group
  sharePostAdmin(String groupID) async {
    showLoading("جلب البيانات");
    var request = {};

    var response = await BaseClient()
        .put(ADMIN_URL + groupID, request)
        .catchError(handleError);

    update();
    hideLoading();

    if (response == null) return;
    getData();
  }



  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
