import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:herba_scan/config.dart';

class UserProvider extends GetConnect {
  @override
  void onInit() {
    GetStorage box = GetStorage();
    httpClient.baseUrl = Config.BACKEND_API_URL;
    httpClient.addRequestModifier<Object?>((request) {
      request.headers['Authorization'] = 'Bearer ${box.read('token')}';
      return request;
    });
    httpClient.timeout = Duration(seconds: 30);
  }

  Future<Response> getUser() => get('/api/v1/user');

  Future<Response> updateUser(Map<String, dynamic> data) =>
      put('/api/v1/user', data);

  Future<Response> updateImage(XFile image) async {
    var formData = FormData({
      "avatar": MultipartFile(image.path, filename: image.name),
    });

    return post('/api/v1/user/avatar', formData);
  }
}
