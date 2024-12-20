import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final storage = GetStorage();

  void logout() {
    storage.remove('isLoggedIn');
    Get.offAllNamed('/login');
  }
}
