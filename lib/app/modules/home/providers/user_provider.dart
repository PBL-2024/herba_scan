import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:herba_scan/config.dart';

class UserProvider extends GetConnect {
  @override
  void onInit() {
    GetStorage box = GetStorage();
    httpClient.baseUrl = Config.BACKEND_API_URL;
    //   set headers with token
    httpClient.addRequestModifier<Object?>((request) {
      request.headers['Authorization'] = 'Bearer ${box.read('token')}';
      return request;
    });
  }

  Future<Response> getUser() => get('/api/v1/user');
}
