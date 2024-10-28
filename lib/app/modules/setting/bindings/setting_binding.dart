import 'package:get/get.dart';

import 'package:herba_scan/app/modules/setting/controllers/upload_plant_controller.dart';

import '../controllers/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadPlantController>(
      () => UploadPlantController(),
    );
    Get.lazyPut<SettingController>(
      () => SettingController(),
    );
  }
}
