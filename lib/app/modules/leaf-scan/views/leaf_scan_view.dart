import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import '../controllers/leaf_scan_controller.dart';

class LeafScanView extends StatefulWidget {
  const LeafScanView({super.key});

  @override
  State<LeafScanView> createState() => _LeafScanViewState();
}

class _LeafScanViewState extends State<LeafScanView> {
  late CameraController _cameraController;
  late List<CameraDescription> cameras;
  bool isCameraReady = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    await _cameraController.initialize();
    setState(() {
      isCameraReady = true;
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeafScanController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'HerbaScan',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          isCameraReady
              ? AspectRatio(
                  aspectRatio: _cameraController.value.aspectRatio,
                  child: CameraPreview(_cameraController),
                )
              : Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.flash_on, color: Colors.green),
                  onPressed: () {
                    // Flash toggle logic here
                  },
                  iconSize: 50,
                ),
                SizedBox(width: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    backgroundColor: Colors.green.withOpacity(0.7),
                  ),
                  onPressed: () async {
                    final image = await _cameraController.takePicture();
                    // Proses gambar
                    //controller.predictImage(image.path);
                  },
                  child: Icon(Icons.camera_alt, color: Colors.black, size: 30),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
