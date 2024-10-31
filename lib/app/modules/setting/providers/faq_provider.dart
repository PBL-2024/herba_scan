import 'package:get/get.dart';
import 'package:herba_scan/config.dart';

class FaqProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Config.BACKEND_API_URL;
    httpClient.timeout = const Duration(seconds: 30);
  }

  Future<Response> getFaqs() => get('/api/v1/faq');
}
