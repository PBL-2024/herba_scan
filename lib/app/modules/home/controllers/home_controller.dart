import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:herba_scan/app/data/themes.dart';
import 'package:herba_scan/app/data/models/favorite_item.dart';
import 'package:herba_scan/app/data/models/plant_response.dart';
import 'package:herba_scan/app/data/models/response_user_favorites.dart';
import 'package:herba_scan/app/data/models/riwayat_item.dart';
import 'package:herba_scan/app/modules/article/controllers/article_controllers.dart';
import 'package:herba_scan/app/modules/auth/providers/auth_provider.dart';
import 'package:herba_scan/app/modules/home/controllers/user_controller.dart';
import 'package:herba_scan/app/modules/home/providers/plant_provider.dart';
import 'package:herba_scan/app/modules/home/providers/user_provider.dart';
import 'package:herba_scan/app/modules/leaf-scan/controllers/leaf_scan_controller.dart';
import 'package:herba_scan/app/modules/plant/controllers/plant_controller.dart';

class HomeController extends GetxController {
  final _authProvider = Get.put(AuthProvider());
  final box = GetStorage();
  final greeting = ''.obs;
  final activeTab = 'Beranda'.obs;
  final RxList<RiwayatItem> riwayat = <RiwayatItem>[].obs;
  final RxList<FavoriteItem> favorites = <FavoriteItem>[].obs;

  final userController = Get.find<UserController>();
  final plantController = Get.find<PlantController>();
  final articleController = Get.find<ArticleController>();

  @override
  void onInit() {
    super.onInit();
    setGreetings();
    getRiwayat();
    getFavorites();
  }

  void logout() {
    _authProvider.logout().then((value) {
      if (value.statusCode == 200) {
        box.remove('token');
        Get.offAllNamed('/auth');
      }
    });
  }

  void setGreetings() {
    greeting.value = getGreetings();
  }

  String getGreetings() {
    var now = DateTime.now();
    var hour = now.hour;
    if (hour < 12) {
      return 'Selamat Pagi';
    } else if (hour < 17) {
      return 'Selamat Siang';
    } else {
      return 'Selamat Malam';
    }
  }

  void getRiwayat() {
    // get riwayat from GetStorage
    final List<RiwayatItem> riwayatList = box.read('riwayat') != null
        ? List<RiwayatItem>.from(
            box.read('riwayat').map((x) => RiwayatItem.fromJson(x)))
        : [];
    riwayat.assignAll(riwayatList);
  }

  void setRiwayat(RiwayatItem item) {
    // add riwayat to GetStorage
    riwayat.insert(0, item);
    // iterate riwayat list to map and save to GetStorage
    final List<Map<String, dynamic>> riwayatList =
        riwayat.map((e) => e.toJson()).toList();
    box.write('riwayat', riwayatList);
  }

  void deleteRiwayat(int hash) {
    riwayat.removeWhere((element) => element.hash == hash);
    final List<Map<String, dynamic>> riwayatList =
        riwayat.map((e) => e.toJson()).toList();

    box.write('riwayat', riwayatList);
  }

  void deleteAllRiwayat() {
    riwayat.clear();
    box.remove('riwayat');
  }

  void dialogConfirmDelete(int hash) {
    Get.defaultDialog(
      title: 'Hapus Riwayat',
      middleText: 'Apakah Anda yakin ingin menghapus riwayat ini?',
      textConfirm: 'Ya',
      textCancel: 'Tidak',
      confirmTextColor: Colors.white,
      onConfirm: () {
        deleteRiwayat(hash);
        Get.back();
      },
      buttonColor: Themes.buttonColor,
      onCancel: () {
        Get.back();
      },
    );
  }

  void dialogConfirmDeleteAll() {
    Get.defaultDialog(
      title: 'Hapus Semua Riwayat',
      content: RichText(
          text: TextSpan(
        text: 'Apakah Anda yakin ingin menghapus semua riwayat?\n',
        style: TextStyle(color: Colors.black),
        children: [
          TextSpan(
            text: 'Tindakan ini tidak dapat dibatalkan',
            style: TextStyle(color: Colors.red),
          ),
        ],
      )),
      textConfirm: 'Ya',
      textCancel: 'Tidak',
      confirmTextColor: Colors.white,
      onConfirm: () {
        deleteAllRiwayat();
        Get.back();
      },
      buttonColor: Themes.buttonColor,
      onCancel: () {
        Get.back();
      },
    );
  }

  void getFavorites() async {
    final userProvider = Get.find<UserProvider>();
    final req = await userProvider.getFavorites();
    if (req.statusCode == 200) {
      final response = userFavoritesFromJson(req.bodyString!);
      final plantFavorites = response.data!.plants!;
      // add type to each plant favorite
      final List<FavoriteItem> plantFavoritesWithType = plantFavorites
          .map((e) => FavoriteItem(
                id: e.id!,
                imgPath: e.coverUrl!,
                title: e.nama!,
                description: e.deskripsi!,
                type: 'tanaman',
              ))
          .toList();

      final articleFavorites = response.data!.articles!;
      // add type to each article favorite
      final List<FavoriteItem> articleFavoritesWithType = articleFavorites
          .map((e) => FavoriteItem(
                id: e.id!,
                imgPath: e.coverUrl!,
                title: e.judul!,
                description: e.shortDesc!,
                type: 'artikel',
              ))
          .toList();

      // add to list
      favorites
          .assignAll([...plantFavoritesWithType, ...articleFavoritesWithType]);
    }
  }

  String cutDescription(String description) {
    if (description.length > 150) {
      return '${description.substring(0, 150)}...';
    } else {
      return description;
    }
  }

  Future<void> openRiwayatScan(RiwayatItem item) async {
    final scanController = Get.put(LeafScanController());
    Completer<void> completer = Completer();
    scanController.showLoadingOverLay(asyncFunction: () async {
      final plantProvider = Get.find<PlantProvider>();
      final req = await plantProvider.getPlantById(item.id);
      final res = SinglePlantResponse.fromJson(req.body);
      scanController.capturedImage.value = item.imgPath;
      scanController.plant.value = res.data!;
    });
    completer.complete();
  }
}
