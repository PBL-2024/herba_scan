import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/themes.dart';
import 'package:herba_scan/app/data/widgets/camera_style.dart';
import 'package:herba_scan/app/data/widgets/reusable_app_bar.dart';
import 'package:herba_scan/app/data/widgets/reusable_button.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/leaf_scan_controller.dart';

class LeafScanView extends GetView<LeafScanController> {
  const LeafScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ReusableAppBar(
        onPressed: () {
          Get.back();
        },
        actions: [
          PopupMenuButton(
            color: Colors.white,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  textStyle: GoogleFonts.poppins(color: Colors.black),
                  labelTextStyle: WidgetStateProperty.all(
                    GoogleFonts.poppins(color: Colors.black),
                  ),
                  value: 'threshold',
                  child: const Text('Ubah Threshold Confidence'),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'threshold') {
                Get.defaultDialog(
                  title: 'Ubah Threshold',
                  content: Obx(
                    () => Column(
                      children: [
                        Text(
                            'Threshold : ${controller.threshold.value * 100 ~/ 1}%'),
                        Slider(
                          thumbColor: Colors.green,
                          activeColor: Colors.green,
                          value: controller.threshold.value,
                          onChanged: (value) {
                            controller.threshold.value = value;
                          },
                          min: 0,
                          max: 1,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ReusableButton(text: 'Simpan', onPressed: () => Get.back()),
                  ],
                );
              }
            },
          ),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                controller.isCameraReady.value
                    ? CameraPreview(
                        controller.cameraController,
                      )
                    : Center(child: CircularProgressIndicator()),
                !controller.isCameraReady.value
                    ? Container()
                    : Positioned.fill(
                        child: Container(
                          decoration: ShapeDecoration(
                            shape: QrScannerOverlayShape(
                              borderColor: Colors.black,
                              overlayColor: Colors.white.withValues(alpha: 0.7),
                              borderRadius: 20,
                              borderLength: 40,
                              borderWidth: 10,
                              cutOutHeight: Get.height * 0.5,
                              cutOutWidth: Get.width * 0.8,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(10),
                        backgroundColor: Themes.buttonCameraBackground,
                      ),
                      onPressed: () async {
                        controller.toggleFlash();
                      },
                      child: Icon(
                          controller.flashOn.value
                              ? Icons.flash_on
                              : Icons.flash_off,
                          color: Themes.backgroundColor,
                          size: 30),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(15),
                        backgroundColor: Themes.buttonCameraBackground,
                      ),
                      onPressed: () async {
                        controller.showLoadingOverLay(asyncFunction: () async {
                          final image =
                              await controller.cameraController.takePicture();
                          await controller.predictImage(image);
                        });
                      },
                      child: Icon(Icons.camera_alt_outlined,
                          color: Themes.backgroundColor, size: 50),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(10),
                        backgroundColor: Themes.buttonCameraBackground,
                      ),
                      onPressed: () async {
                        controller.showLoadingOverLay(asyncFunction: () async {
                          final image = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                            maxHeight: 500,
                            maxWidth: 500,
                          );
                          if (image != null) {
                            controller.predictImage(image);
                          }
                        });
                      },
                      child: Icon(Icons.image,
                          color: Themes.backgroundColor, size: 30),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
