import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:herba_scan/app/modules/auth/providers/auth_provider.dart';
import 'package:herba_scan/app/modules/home/providers/user_provider.dart';

class HomeController extends GetxController {
  final _userProvider = Get.find<UserProvider>();
  final _authProvider = Get.put(AuthProvider());
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void logout() {
    _authProvider.logout().then((value) {
      if (value.statusCode == 200) {
        box.remove('token');
        Get.offAllNamed('/auth');
      }
    });
  }
}
