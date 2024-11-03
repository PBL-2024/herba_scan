import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:herba_scan/app/data/models/response_unclassified_plant.dart';
import 'package:herba_scan/app/data/widgets/reusable_button.dart';
import 'package:herba_scan/app/data/widgets/reusable_input_field.dart';
import 'package:herba_scan/app/modules/home/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';

class UploadPlantController extends GetxController {
  final isEmpty = false.obs;
  final labelController = TextEditingController();

  final listUnclassifiedPlant = <Plant>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUnclassifiedPlant();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void selectSource() {
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
            width: double.infinity,
            child: Wrap(
              children: [
                Column(
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
                      onTap: () {
                        Get.back();
                        pickAndUploadImage(ImageSource.camera);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.photo),
                      title: Text('Galeri'),
                      onTap: () {
                        Get.back();
                        pickAndUploadImage(ImageSource.gallery);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<String> setLabel() async {
    Completer<String> completer = Completer<String>();
    Get.bottomSheet(
      BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            height: 250,
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
                ReusableInputField(
                  title: 'Masukkan Nama Tanaman (Opsional)',
                  controller: labelController,
                  validator: (val) => null,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableButton(
                  text: 'Simpan',
                  onPressed: () {
                    completer.complete(labelController.text);
                    Get.back();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );

    return completer.future;
  }

  Future<void> pickAndUploadImage(ImageSource source) async {
    try {
      final userProvider = Get.put(UserProvider());
      final image = await ImagePicker()
          .pickImage(source: source, maxHeight: 500, imageQuality: 50);
      if (image == null) return;
      final label = await setLabel();
      final data = {
        'label': label,
        'image': image,
      };
      print(data);
      final response = await userProvider.postPlant(data);
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Data berhasil diupload");
      } else {
        throw 'Periksa kembali data yang diinput';
      }
      labelController.clear();
      getUnclassifiedPlant();
    } catch (e) {
      labelController.clear();
      Get.snackbar("Gagal", e.toString());
      getUnclassifiedPlant();
    }
  }

  void getUnclassifiedPlant() async {
    final userProvider = Get.put(UserProvider());
    final response = await userProvider.getUnclassifiedPlants();
    final res = UnclassifiedPlantResponse.fromJson(response.body);
    if (res.data == null) {
      isEmpty.value = true;
    } else {
      listUnclassifiedPlant.assignAll(res.data! as Iterable<Plant>);
      isEmpty.value = false;
    }
  }
}
