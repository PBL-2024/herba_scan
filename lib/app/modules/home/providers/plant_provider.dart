import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:herba_scan/config.dart';

class PlantProvider extends GetConnect {
  @override
  void onInit() {
    final box = GetStorage();
    httpClient.baseUrl = Config.BACKEND_API_URL;
    httpClient.addRequestModifier<Object?>((request) {
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer ${box.read('token')}';
      return request;
    });
  }

  Future<Response> getPlants({String filter = 'terbaru'}) => get('/api/v1/plants',query: {'filter': filter});

  Future<Response> getPlantById(int id) => get('/api/v1/plant/$id');

  Future<Response> searchPlant(String keyword) => get('/api/v1/plant/search/$keyword');

  Future<Response> setFavorite(int id) => post('/api/v1/plant/favorite', {'plant_id': id});

  Future<Response> isFavorite(int id) => post('/api/v1/plant/is-favorite', {'plant_id': id});

  Future<Response> getPlantByName(String name) => get('/api/v1/plant/name/$name');
}
