import 'package:get/get.dart';
import 'package:herba_scan/app/modules/leaf-scan/views/scan_result_view.dart';
import 'package:herba_scan/app/modules/setting/views/upload_plant_view.dart';

import '../modules/article/bindings/article_binding.dart';
import '../modules/article/views/article_view.dart';
import '../modules/article/views/detail_article_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/auth/views/forget_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/leaf-scan/bindings/leaf_scan_binding.dart';
import '../modules/leaf-scan/views/leaf_scan_view.dart';
import '../modules/plant/bindings/plant_binding.dart';
import '../modules/plant/views/detail_view.dart';
import '../modules/plant/views/plant_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.HOME;
  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LEAF_SCAN,
      page: () => const LeafScanView(),
      binding: LeafScanBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_RESULT,
      page: () => const ScanResultView(),
      binding: LeafScanBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.PLANT,
      page: () => const PlantView(),
      binding: PlantBinding(),
    ),
    GetPage(
      name: _Paths.PLANT_DETAIL,
      page: () => const PlantDetailView(),
      binding: PlantBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => const ForgetPasswordView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.ARTICLE,
      page: () => const ArticleView(),
      binding: ArticleBinding(),
    ),
    GetPage(
      name: _Paths.ARTICLE_DETAIL,
      page: () => const ArticleDetailView(),
      binding: ArticleBinding(),
    ),
    GetPage(
      name: _Paths.UPLOAD_PLANT,
      page: () => const UploadPlantView(),
      binding: SettingBinding(),
    ),
  ];
}
