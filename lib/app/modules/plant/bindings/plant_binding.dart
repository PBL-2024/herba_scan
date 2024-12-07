import 'package:get/get.dart';

import '../controllers/plant_controller.dart';

class PlantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlantController>(
      () => PlantController(),
    );
  }
}
