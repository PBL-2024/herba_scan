import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/models/plant_response.dart';
import 'package:herba_scan/app/data/models/response_prediction.dart'
    as prediction;
import 'package:herba_scan/app/data/models/riwayat_item.dart';
import 'package:herba_scan/app/data/themes.dart';
import 'package:herba_scan/app/data/widgets/reusable_button.dart';
import 'package:herba_scan/app/modules/home/controllers/home_controller.dart';
import 'package:herba_scan/app/modules/home/controllers/user_controller.dart';
import 'package:herba_scan/app/modules/home/providers/plant_provider.dart';
import 'package:herba_scan/app/modules/leaf-scan/providers/predict_provider.dart';
import 'package:herba_scan/app/routes/app_pages.dart';
import 'package:path_provider/path_provider.dart';

class LeafScanController extends GetxController {
  final PredictProvider predictProvider = Get.put(PredictProvider());
  final predictResult = ''.obs;
  final capturedImage = ''.obs;
  final isLoading = false.obs;
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  final isCameraReady = false.obs;
  final flashOn = false.obs;
  final userAttempt = 0.obs;
  final userController = Get.find<UserController>();
  final plant = Plant().obs;
  final homeController = Get.find<HomeController>();
  final threshold = 0.8.obs;

  @override
  void onReady() {
    super.onReady();
    initializeCamera();
  }

  @override
  void onClose() {
    super.onClose();
    cameraController.dispose();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.high);
    await cameraController.initialize();
    isCameraReady.value = true;
  }

  Future<void> predictImage(XFile file) async {
    isLoading.value = true;
    try {
      final response = await predictProvider.predict(file);
      if (response.statusCode == 200) {
        await _handlePredictionResponse(response, file);
      } else {
        _showError();
      }
    } catch (e) {
      _showError();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _handlePredictionResponse(Response response, XFile file) async {
    final result = prediction.Prediction.fromJson(response.body);
    if (result.images[0].results[0].confidence < threshold.value) {
      _handleLowConfidence();
    } else {
      await _saveAndProcessImage(file, result.images[0].results[0].name);
    }
  }

  void _handleLowConfidence() {
    predictResult.value = 'Not Found';
    if (userAttempt.value < 3) {
      userAttempt.value++;
      showPredictNotFound();
    } else {
      showContributionDialog();
    }
  }

  Future<void> _saveAndProcessImage(XFile file, String plantName) async {
    final String savePath = await _saveImage(file);
    capturedImage.value = savePath;
    userAttempt.value = 0;
    predictResult.value = plantName;
    await _fetchAndSetPlantData(plantName, savePath);
  }

  Future<String> _saveImage(XFile file) async {
    final String path =
        await getApplicationDocumentsDirectory().then((value) => value.path);
    final Directory dir = Directory('$path/scan-history');
    if (!dir.existsSync()) {
      dir.createSync();
    }
    final String fileName = file.name;
    final String savePath = '$path/scan-history/$fileName';
    await file.saveTo(savePath);
    return savePath;
  }

  Future<void> _fetchAndSetPlantData(String plantName, String savePath) async {
    final plantProvider = Get.find<PlantProvider>();
    final req = await plantProvider.getPlantByName(plantName);
    if (req.statusCode == 200) {
      final res = SinglePlantResponse.fromJson(req.body);
      plant.value = res.data!;
      final riwayat = RiwayatItem(
        id: res.data!.id!,
        imgPath: savePath,
        title: res.data!.nama!,
        description: 'Scan Tanaman Berhasil',
        type: 'scan',
        hash: DateTime.now().hashCode,
      );
      homeController.setRiwayat(riwayat);
      Get.toNamed(Routes.SCAN_RESULT);
    } else {
      showPredictNotFound();
    }
  }

  void _showError() {
    predictResult.value = 'Error';
    showPredictNotFound(msg: 'An error occurred while predicting the image.');
  }

  void toggleFlash() {
    flashOn.value = !flashOn.value;
    cameraController
        .setFlashMode(flashOn.value ? FlashMode.torch : FlashMode.off);
  }

  showLoadingOverLay({
    required Future<dynamic> Function() asyncFunction,
    String? msg,
  }) async {
    await Get.showOverlay(
      asyncFunction: () async {
        try {
          await asyncFunction();
        } catch (error) {
          if (kDebugMode) {
            debugPrint('Error: $error');
          }
        }
      },
      loadingWidget: Center(
        child: _getLoadingIndicator(),
      ),
      opacity: 0.7,
      opacityColor: Colors.black,
    );
  }

  Widget _getLoadingIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: CircularProgressIndicator(
        color: Themes.buttonColor,
      ),
    );
  }

  void showPredictNotFound({String msg = 'Tanaman tidak ditemukan'}) {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // divider with container
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: 100,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Image(image: AssetImage('assets/images/no_data.png')),
            SizedBox(height: 20),
            Text(
              msg,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w500)
                      .fontFamily),
            ),
            SizedBox(height: 20),
            ReusableButton(
              text: 'Ulangi',
              onPressed: () {
                Get.back();
              },
              textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w600)
                      .fontFamily),
            ),
          ],
        ),
      ),
    );
  }

  void showContributionDialog() {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // divider with container
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: 100,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Image(image: AssetImage('assets/images/no_data.png')),
            SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily:
                          GoogleFonts.poppins(fontWeight: FontWeight.w500)
                              .fontFamily),
                  text:
                      'Sepertinya tanaman ini belum di klasifikasi. \n\nKamu bisa membantu kami dengan mengirimkan gambar tanaman ini ke kami. \n\nKami akan memproses gambar tersebut dan menambahkan klasifikasi tanaman ini ke dalam aplikasi kami.'),
            ),
            SizedBox(height: 20),
            if (userController.checkToken())
              ReusableButton(
                text: 'Unggah Tanaman',
                onPressed: () {
                  Get.offNamed(Routes.UPLOAD_PLANT);
                },
                textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w600)
                        .fontFamily),
              ),
            if (!userController.checkToken())
              ReusableButton(
                text: 'Masuk',
                onPressed: () {
                  Get.offNamed(Routes.AUTH);
                },
                textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w600)
                        .fontFamily),
              ),
          ],
        ),
      ),
    );
  }
}
