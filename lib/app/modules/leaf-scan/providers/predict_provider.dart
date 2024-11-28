import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:herba_scan/config.example.dart';

class PredictProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Config.MODEL_API_URL;
    httpClient.addRequestModifier<Object?>((request) {
      request.headers['x-api-key'] = Config.MODEL_API_KEY;
      return request;
    });
    //   Timeout
    httpClient.timeout = const Duration(seconds: 10);
  }

  Future<Response> predict(XFile image) async {
    var data = FormData({
      'file': MultipartFile(image.path, filename: image.name),
      'model': Config.MODEL_URL,
      'imgsz': '640',
      'conf': '0.90',
      'iou': '0.25'
    });

    return post('/', data);
  }
}
