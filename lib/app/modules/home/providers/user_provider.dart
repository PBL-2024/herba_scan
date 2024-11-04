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

  Future<Response> getUser() =>
      get('/api/v1/user', headers: {'Accept': 'application/json'});

  Future<Response> updateUser(Map<String, dynamic> data) =>
      put('/api/v1/user', data);

  Future<Response> updateImage(XFile image) async {
    var formData = FormData({
      "avatar": MultipartFile(image.path, filename: image.name),
    });

    return post('/api/v1/user/avatar', formData);
  }

  Future<Response> changePassword(Map<String, dynamic> data) =>
      put('/api/v1/user/change-password', data,
          contentType: 'application/json');

  Future<Response> postPlant(Map<String, dynamic> data) async {
    final formData = FormData({
      "nama": data['label'],
      "file": MultipartFile(data['image'].path, filename: data['image'].name),
    });
    final response = await post('/api/v1/unclassified-plant', formData,
        contentType: 'multipart/form-data');
    return response;
  }

  Future<Response> getUnclassifiedPlants() =>
      get('/api/v1/unclassified-plants', headers: {'Accept': 'application/json'});

  Future<Response> deleteUnclassifiedPlant(String id) =>
      delete('/api/v1/unclassified-plant/$id');

  Future<Response> sendOtp(Map<String, dynamic> data) =>
      post('/api/v1/user/otp/send', data, contentType: 'application/json');
}
