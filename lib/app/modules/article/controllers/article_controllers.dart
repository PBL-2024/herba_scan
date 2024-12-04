import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ArticleController extends GetxController {
  var articles = <Map<String, String>>[].obs; // Semua artikel
  var filteredArticles = <Map<String, String>>[].obs; // Artikel yang difilter
  var isLoading = true.obs;
  var selectedImage = Rxn<File>();
  var articleTitle = ''.obs;
  var articleDescription = ''.obs;
  var selectedFilter = ''.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }

  void fetchArticles() async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 1));

      articles.assignAll([
        {
          "title": "Daun Kemangi Bisa Buat Kaya Lho...",
          "description": "Daun Kemangi kaya manfaat...",
          "imageUrl": "images/diet.jpg",
        },
        {
          "title": "Aloe Vera untuk Kesehatan Kulit...",
          "description": "Aloe Vera memberikan banyak manfaat...",
          "imageUrl": "images/diet.jpg",
        }
      ]);
    } catch (error) {
      // Log or show error messages if necessary
      print("Error fetching articles: $error");
    } finally {
      isLoading(false);
    }
  }

  void filterArticles(String query) {
    if (query.isEmpty) {
      filteredArticles.assignAll(articles); // Tampilkan semua artikel jika pencarian kosong
    } else {
      filteredArticles.assignAll(
        articles.where((article) {
          final title = article['title']?.toLowerCase() ?? '';
          return title.contains(query.toLowerCase());
        }).toList(),
      );
    }
  }
}
