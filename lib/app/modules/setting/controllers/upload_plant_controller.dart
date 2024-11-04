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

  final _isProcessing = false.obs;

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
                      onTap: () async {
                        pickAndUploadImage(ImageSource.camera);
                        await Future.delayed(Duration(seconds: 1));
                        Get.back();
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.photo),
                      title: Text('Galeri'),
                      onTap: () async {
                        pickAndUploadImage(ImageSource.gallery);
                        await Future.delayed(Duration(seconds: 1));
                        Get.back();
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
    if (res.data!.isEmpty) {
      isEmpty.value = true;
      listUnclassifiedPlant.clear();
    } else {
      listUnclassifiedPlant.assignAll(res.data! as Iterable<Plant>);
      isEmpty.value = false;
    }
  }

  Future<void> deletePlant(String id) async {
    final userProvider = Get.put(UserProvider());
    final response = await userProvider.deleteUnclassifiedPlant(id);
    if (response.statusCode == 200) {
      Get.snackbar("Berhasil", "Data berhasil dihapus");
    } else {
      Get.snackbar("Gagal", "Data gagal dihapus");
    }
    getUnclassifiedPlant();
  }

  void deleteBottomSheet(String id) {
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
                    Text("Apakah anda yakin ingin menghapus data ini?"),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Obx(
                            () => ReusableButton(
                              isLoading: _isProcessing.value,
                              text: 'Ya',
                              buttonStyle: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.red,
                                ),
                                fixedSize: WidgetStateProperty.all(
                                  Size(double.infinity, 50),
                                ),
                              ),
                              onPressed: () async {
                                _isProcessing.value = true;
                                await Future.delayed(Duration(seconds: 1));
                                _isProcessing.value = false;
                                Get.back();
                                deletePlant(id);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ReusableButton(
                            text: 'Tidak',
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ],
                      ),
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
}
