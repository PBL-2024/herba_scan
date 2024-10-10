import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:herba_scan/app/modules/leaf-scan/views/leaf_scan_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Get.to(() => LeafScanView()),
          child: Text("Scan Daun"),
        ),
      ),
    );
  }
}
