import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:herba_scan/app/modules/article/providers/article_provider.dart';

class ArticleController extends GetxController {
  final ArticleProvider _articleProvider = ArticleProvider();

  // Observables
  var isLoading = true.obs;
  var articles = <Map<String, dynamic>>[].obs;
  var filteredArticles = RxList<Map<String, dynamic>>([]);
  var selectedFilter = 'terbaru'.obs;
  var articleTitle = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }

  /// Mengambil daftar artikel dari provider
  Future<void> fetchArticles() async {
    isLoading.value = true;

    final response = await _articleProvider.fetchArticles();
    if (response.statusCode == 200 && response.body != null) {
      // Parsing data
      final List<dynamic> data = response.body['data'] ?? [];
      articles.assignAll(data.cast<Map<String, dynamic>>());
      applySearchFilter(); // Terapkan filter awal
    } else {
      print('Error fetching articles: ${response.body}');
    }

    isLoading.value = false;
  }

  /// Memperbarui filter berdasarkan kategori
  void updateFilter(String filter) {
    selectedFilter.value = filter;
    applySearchFilter();
  }

  /// Menerapkan filter pencarian dan kategori
  void applySearchFilter() {
    List<Map<String, dynamic>> tempArticles = articles;

    // Filter pencarian
    if (articleTitle.isNotEmpty) {
      tempArticles = tempArticles
          .where((article) {
            final title = (article['title'] ?? '').toString().toLowerCase();
            final description = (article['description'] ?? '').toString().toLowerCase();
            return title.contains(articleTitle.value.toLowerCase()) ||
                description.contains(articleTitle.value.toLowerCase());
          })
          .toList();
    }

    // Filter kategori
    if (selectedFilter.value == 'terbaru') {
      tempArticles.sort((a, b) => b['created_at'].compareTo(a['created_at']));
    } else if (selectedFilter.value == 'populer') {
      tempArticles.sort((a, b) => b['views'].compareTo(a['views']));
    } else if (selectedFilter.value == 'paling lama') {
      tempArticles.sort((a, b) => a['created_at'].compareTo(b['created_at']));
    }

    filteredArticles.assignAll(tempArticles);
  }
}
