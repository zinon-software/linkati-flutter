import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/base_client.dart';
import '../services/urls.dart';
import 'base_controller.dart';

class UsersController extends GetxController with BaseController {
  var userList = <Users>[].obs;

  // get controller
  Future<void> getUsers() async {
  
    var response = await BaseClient().get(
      api: USERS_URL,
    ).catchError(handleError);

    update();

    if (response != null) {
      userList.value = usersFromJson(response);
    } else {
      return;
    }
  }

    @override
  void onInit() {
    getUsers();
    super.onInit();
  }
}
