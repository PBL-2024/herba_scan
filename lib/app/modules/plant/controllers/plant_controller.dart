import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:herba_scan/app/data/models/plant_response.dart';
import 'package:herba_scan/app/data/models/response_article.dart';
import 'package:herba_scan/app/data/models/riwayat_item.dart';
import 'package:herba_scan/app/modules/article/providers/article_provider.dart';
import 'package:herba_scan/app/modules/home/controllers/home_controller.dart';
import 'package:herba_scan/app/modules/home/controllers/user_controller.dart';
import 'package:herba_scan/app/modules/home/providers/plant_provider.dart';

class PlantController extends GetxController {
  final isLoading = false.obs;
  final RxList<Plant> plants = <Plant>[].obs;
  final seachController = TextEditingController();
  final filterSelected = 'terbaru'.obs;
  final Rx<Plant?> selectedPlant = Plant().obs;
  final detailMenu = 0.obs;
  final isFavoritePlant = false.obs;

  @override
  void onInit() {
    super.onInit();
    getPlant();
  }

  void getPlant({String filter = 'terbaru'}) {
    isLoading.value = true;
    final plantProvider = Get.find<PlantProvider>();
    plantProvider
        .getPlants(filter: filter)
        .then(
          (value) {
            if (value.statusCode == 200) {
              final response = plantResponseFromJson(value.bodyString!);
              plants.value = response.data!;
            }
          },
        )
        .whenComplete(() => isLoading.value = false)
        .onError(
          (error, stackTrace) {
            isLoading.value = false;
            if (kDebugMode) {
              debugPrint('Error: $error');
            }
          },
        );
  }

  void searchPlant() async {
    isLoading.value = true;
    final plantProvider = Get.find<PlantProvider>();
    plantProvider
        .searchPlant(seachController.text)
        .then(
          (value) {
            if (value.statusCode == 200) {
              final response = plantResponseFromJson(value.bodyString!);
              plants.value = response.data!;
            } else if (seachController.text == '') {
              getPlant();
            } else if (value.statusCode == 404) {
              plants.clear();
            }
          },
        )
        .whenComplete(() => isLoading.value = false)
        .onError(
          (error, stackTrace) {
            isLoading.value = false;
            if (kDebugMode) {
              debugPrint('Error: $error');
            }
          },
        );
  }

  void getPlantById(int id) async {
    isLoading.value = true;
    selectedPlant.refresh();
    final plantProvider = Get.find<PlantProvider>();
    final req = await plantProvider.getPlantById(id);
    if (req.statusCode == 200) {
      final response = singlePlantResponseFromJson(req.bodyString!);
      selectedPlant.value = response.data!;
      final RiwayatItem item = RiwayatItem(
        id: response.data!.id!,
        title: response.data!.nama!,
        imgPath: response.data!.coverUrl!,
        description: response.data!.deskripsi!,
        type: "tanaman",
        hash: DateTime.now().hashCode,
      );
      final homeController = Get.find<HomeController>();
      homeController.setRiwayat(item);
    }
    isLoading.value = false;
  }

  void setFavorite(int id) {
    final userController = Get.find<UserController>();
    if (userController.checkToken()) {
      final plantProvider = Get.find<PlantProvider>();
      plantProvider.setFavorite(id).then((value) {
        if (value.statusCode == 200) {
          final response = plantFavoriteFromJson(value.bodyString!);
          Get.snackbar('Berhasil', response.message!);
        }
        isFavorite(id);

        final homeController = Get.find<HomeController>();
        homeController.getFavorites();
      });
    } else {
      userController.confirmAuth();
    }
  }

  void isFavorite(int id) {
    final userController = Get.find<UserController>();
    if (userController.checkToken()) {
      final plantProvider = Get.find<PlantProvider>();
      plantProvider.isFavorite(id).then((value) {
        if (value.statusCode == 200) {
          final response = plantFavoriteFromJson(value.bodyString!);
          isFavoritePlant.value = response.data!;
        }
      });
    }
  }
}
