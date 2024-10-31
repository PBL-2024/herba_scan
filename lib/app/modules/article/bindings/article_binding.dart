import 'package:get/get.dart';
import '../controllers/article_controllers.dart';
import '../providers/provider.dart';

class ArticleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArticleController>(() => ArticleController());
    Get.lazyPut<ArticleProvider>(() => ArticleProvider());
  }
}
