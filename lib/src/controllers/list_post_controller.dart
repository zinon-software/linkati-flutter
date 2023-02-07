import 'package:get/get.dart';
import 'package:linkati/src/models/post_model.dart';
import '../services/base_client.dart';
import '../services/urls.dart';
import 'base_controller.dart';

class ListPostController extends GetxController with BaseController {
  var postOrGroupList = <Posts>[].obs;

  // get controller
  Future<void> getData(String apiName) async {

    var response = await BaseClient()
        .get(
          api: GROUPS_URL + apiName,
        )
        .catchError(handleError);
    update();

    if (response != null) {
      postOrGroupList.value = postsFromJson(response);
    } else {
      return;
    }
  }
}
