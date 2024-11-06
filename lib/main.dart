import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:herba_scan/app/modules/article/views/article_view.dart';
import 'package:herba_scan/app/modules/article/controllers/article_controllers.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      home: ArticleView(),  // Set ArticleView as the initial screen
      // Remove or comment out initialRoute if not using routes
      // initialRoute: AppPages.INITIAL,
      // getPages: AppPages.routes,
      initialBinding: BindingsBuilder(() {
        Get.put(ArticleController()); // Bind ArticleController here
      }),
    );
  }
}
