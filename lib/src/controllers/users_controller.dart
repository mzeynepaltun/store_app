import 'package:get/get.dart';
import '../services/http_service.dart';

class UsersController extends GetxController {
  var isLoading = true.obs;
  var usersList = [].obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    try {
      isLoading(true);
      var users = await HttpService.fetchUsers();
      if (users != null) {
        usersList.value = users;
      }
    } finally {
      isLoading(false);
    }
  }
}
