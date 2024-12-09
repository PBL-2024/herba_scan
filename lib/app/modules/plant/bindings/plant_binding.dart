import 'package:get/get.dart';
import 'package:herba_scan/app/modules/home/controllers/home_controller.dart';
import 'package:herba_scan/app/modules/home/controllers/user_controller.dart';
import 'package:herba_scan/app/modules/home/providers/plant_provider.dart';

import '../controllers/plant_controller.dart';

class PlantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlantController>(() => PlantController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PlantProvider>(() => PlantProvider());
    Get.lazyPut<UserController>(() => UserController());
  }
}
