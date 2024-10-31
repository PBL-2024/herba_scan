import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:herba_scan/app/data/models/response_avatar_update.dart';
import 'package:herba_scan/app/data/models/response_user.dart';
import 'package:herba_scan/app/modules/auth/providers/auth_provider.dart';
import 'package:herba_scan/app/modules/home/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';

class SettingController extends GetxController {
  final _userProvider = Get.put(UserProvider());
  final _authProvider = Get.put(AuthProvider());
  final box = GetStorage();
  late final Rx<UserResponse> user = UserResponse().obs;
  final isLoading = false.obs;

  // Profile
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void logout() {
    _authProvider.logout().then((value) {
      if (value.statusCode == 200) {
        box.remove('token');
        Get.offAllNamed('/home');
      }
    });
  }

  Future<void> getUser() async {
    try {
      final response = await _userProvider.getUser();
      user.value = UserResponse.fromJson(response.body);
      nameController.text = user.value.data!.name!;
      emailController.text = user.value.data!.email!;
    } catch (e) {
      Get.snackbar(
          'Terjadi Kesalahan', 'Periksa koneksi internet anda dan coba lagi');
    }
  }

  Future<void> changeName() async {
    isLoading.value = true;
    final Map<String, dynamic> data = {
      'name': nameController.text,
    };
    _userProvider.updateUser(data).then((value) {
      if (value.statusCode == 200) {
        Get.snackbar('Berhasil', 'Nama berhasil diubah');
        getUser();
      } else {
        Get.snackbar('Gagal', 'Gagal mengubah nama');
      }
      isLoading.value = false;
    });
  }

  Future<void> pickImage() async {
    Get.bottomSheet(
      BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            height: 150,
            width: double.infinity,
            child: Column(
              children: [
                //   Black line
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Kamera'),
                  onTap: () async {
                    pickAndUploadImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Galeri'),
                  onTap: () async {
                    pickAndUploadImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> pickAndUploadImage(ImageSource source) async {
    try {
      Get.back();
      final image = await ImagePicker()
          .pickImage(source: source, maxHeight: 500, imageQuality: 50);
      if (image == null) return;

      final response = await _userProvider.updateImage(image);
      final res = AvatarUpdateResponse.fromJson(response.body);

      Get.snackbar(
          response.statusCode == 200 ? 'Berhasil' : 'Gagal', res.message!);
      getUser();
    } catch (e) {
      Get.snackbar("Gagal", "Terjadi kesalahan");
    }
  }
}
