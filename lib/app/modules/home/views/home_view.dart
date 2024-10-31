import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:herba_scan/app/modules/auth/controllers/auth_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    final auth_controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => Get.toNamed("/setting"),
              child: Text("Setting"),
            ),
            ElevatedButton(
              onPressed: () => auth_controller.logout(),
              child: Text("Keluar"),
            ),
          ],
        ),
      ),
    );
  }
}
