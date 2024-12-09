import 'package:get/get.dart';

import 'package:herba_scan/app/modules/auth/controllers/auth_controller.dart';
import 'package:herba_scan/app/modules/home/controllers/user_controller.dart';
import 'package:herba_scan/app/modules/home/providers/plant_provider.dart';
import 'package:herba_scan/app/modules/home/providers/user_provider.dart';
import 'package:herba_scan/app/modules/leaf-scan/controllers/leaf_scan_controller.dart';
import 'package:herba_scan/app/modules/leaf-scan/providers/predict_provider.dart';
import 'package:herba_scan/app/modules/plant/controllers/plant_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(
      () => UserController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
    Get.lazyPut<UserProvider>(
      () => UserProvider(),
    );
    Get.lazyPut<PlantProvider>(
      () => PlantProvider(),
    );
    Get.lazyPut<PlantController>(
      () => PlantController(),
    );
  }
}
