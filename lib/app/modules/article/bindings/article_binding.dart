import 'package:get/get.dart';
import 'package:herba_scan/app/modules/home/controllers/user_controller.dart';
import '../controllers/article_controllers.dart';
import '../providers/article_provider.dart';

class ArticleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArticleController>(() => ArticleController());
    Get.lazyPut<ArticleProvider>(() => ArticleProvider());
    Get.lazyPut<UserController>(() => UserController());
  }
}
