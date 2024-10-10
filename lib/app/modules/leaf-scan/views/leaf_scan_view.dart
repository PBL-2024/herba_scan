import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/leaf_scan_controller.dart';

class LeafScanView extends GetView<LeafScanController> {
  const LeafScanView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeafScanController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('LeafScanView'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              controller.isLoading.value
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
                        Text("Result:"),
                        Text(controller.predictResult.value),
                      ],
                    ),
              ElevatedButton(
                onPressed: () {
                  controller.isLoading.value = true;
                  controller.predictImage();
                },
                child: Text("Pick Image"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
