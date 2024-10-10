import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/leaf-scan/bindings/leaf_scan_binding.dart';
import '../modules/leaf-scan/views/leaf_scan_view.dart';

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
  ];
}
