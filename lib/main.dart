import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:herba_scan/app/modules/auth/controllers/auth_controller.dart';
import 'app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

// coba frontend
// import 'package:flutter/material.dart';
// import 'package:herba_scan/app/homePage.dart';
// import 'package:herba_scan/app/modules/home/views/home_view.dart';

// void main() {
//   runApp(const HomeView());
// }
