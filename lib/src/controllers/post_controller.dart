import 'package:get/get.dart';
import 'package:linkati/src/models/post_model.dart';
import '../services/base_client.dart';
import '../services/urls.dart';
import 'base_controller.dart';

class PostController extends GetxController with BaseController {
  var postsList = <Posts>[].obs;

  // get controller
  Future<void> getData() async {

    var response = await BaseClient()
        .get(
          api: GROUPS_URL,
        )
        .catchError(handleError);
    update();

    if (response != null) {
      postsList.value = postsFromJson(response);
    } else {
      return;
    }
  }

  // delete group
  deleteGroup({required String groupID}) async {

    showLoading("جلب البيانات");

    var response = await BaseClient()
        .delete(GROUPS_URL + groupID)
        .catchError(handleError);

    update();
    hideLoading();
    if (response == null) return;
    getData();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
