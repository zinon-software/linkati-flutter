import '../services/base_client.dart';
import '../services/urls.dart';
import 'base_controller.dart';
import 'package:get/get.dart';

class LikeController extends GetxController with BaseController {
  // get controller
  Future<void> getData({String? postID}) async {
    var url = LIKE_URL + postID!;

    var response = await BaseClient()
        .get(
          api: url,
        )
        .catchError(handleError);
    update();

    if (response != null) {
    } else {
      return;
    }
  }
}
