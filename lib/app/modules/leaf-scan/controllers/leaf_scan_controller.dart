import 'package:get/get.dart';
import 'package:herba_scan/app/data/models/prediction.dart';
import 'package:herba_scan/app/modules/leaf-scan/providers/predict_provider.dart';
import 'package:image_picker/image_picker.dart';

class LeafScanController extends GetxController {
  final PredictProvider predictProvider = Get.put(PredictProvider());
  final predictResult = ''.obs;
  final isLoading = false.obs;
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

  void predictImage() async {
    //   Pick an image from gallery or capture from camera
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      // Convert image to List<int>
      final response = await predictProvider.predict(image);
      if (response.statusCode == 200) {
        final result = Prediction.fromJson(response.body);
        predictResult.value = result.images[0].results[0].name;
      }
    }
    isLoading.value = false;
  }
}
