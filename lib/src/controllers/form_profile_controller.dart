import '../../main.dart';
import '../models/avatar_model.dart';
import '../services/base_client.dart';
import '../services/urls.dart';
import 'base_controller.dart';
import 'package:get/get.dart';

class FormProfileController extends GetxController with BaseController {
  var avaterList = <AvatarModel>[].obs;

  RxBool isLoading = false.obs;

  Future<void> fetchAvatar() async {
    var response = await BaseClient()
        .get(
          api: AVATAR_URL,
        )
        .catchError(handleError);
    if (response != null) {
      avaterList.value = avatarModelFromJson(response);
      update();
    } else {
      return;
    }
  }

  Future<void> putProfile(
      {String? name, String? avatar, String? description}) async {
    isLoading(true);
    var request = {'name': name, 'avatar': avatar, 'description': description};

    var response = await BaseClient()
        .put(PROFILE_URL + prefs!.getInt('user_id').toString(), request)
        .catchError(handleError);

    update();

    if (response == null) {
      isLoading(false);
      return;
    }
    isLoading(false);
  }

  @override
  void onInit() {
    fetchAvatar();
    super.onInit();
  }
}
