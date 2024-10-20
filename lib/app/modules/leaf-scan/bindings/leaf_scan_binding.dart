import 'package:get/get.dart';
import 'package:herba_scan/app/modules/leaf-scan/providers/predict_provider.dart';

import '../controllers/leaf_scan_controller.dart';

class LeafScanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeafScanController>(
      () => LeafScanController(),
    );
    Get.lazyPut<PredictProvider>(
      () => PredictProvider(),
    );
  }
}
