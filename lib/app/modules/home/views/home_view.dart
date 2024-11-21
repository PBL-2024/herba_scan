import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:herba_scan/app/modules/auth/controllers/auth_controller.dart';
import 'package:herba_scan/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    final auth_controller = Get.put(AuthController());
    final String? id = Get.parameters['id'];
    return Scaffold(
      key: UniqueKey(),
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text('HomeView is working'),
            Text('Id from route is $id'),
            ElevatedButton(
              onPressed: () => Get.toNamed(Routes.SETTING),
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
