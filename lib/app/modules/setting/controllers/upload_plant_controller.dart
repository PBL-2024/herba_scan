import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:herba_scan/app/data/widgets/reusable_button.dart';
import 'package:herba_scan/app/data/widgets/reusable_input_field.dart';

class UploadPlantController extends GetxController {
  final isEmpty = false.obs;

  @override
  void onInit() {
    super.onInit();
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
                  onTap: () {
                    Get.back();
                    setLabel();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Galeri'),
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void setLabel() {
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
                  controller: TextEditingController(),
                  validator: (val) => null,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableButton(
                  text: 'Simpan',
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
