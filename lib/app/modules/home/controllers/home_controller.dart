import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:herba_scan/app/modules/home/providers/user_provider.dart';

class HomeController extends GetxController {
  final _userProvider = Get.find<UserProvider>();
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void checkAuthStatus() {
    _userProvider.getUser().then((value) {
      if (value.statusCode == 200) {
        Get.snackbar('Halo...', 'Selamat Datang');
      } else {
        box.remove('token');
        Get.offAllNamed('/auth');
      }
    });
  }
}
