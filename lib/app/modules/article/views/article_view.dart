import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/themes.dart';
import 'package:herba_scan/app/data/models/response_article.dart';
import 'package:herba_scan/app/modules/article/controllers/article_controllers.dart';
import 'package:herba_scan/app/routes/app_pages.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ArticleView extends GetView<ArticleController> {
  const ArticleView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchArticles();
    });
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          controller.searchArticle('');
          controller.updateFilter('terbaru');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Artikel Kesehatan',
            style: TextStyle(
              fontFamily:
                  GoogleFonts.poppins(fontWeight: FontWeight.w600).fontFamily,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_sharp),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onSubmitted: (value) {
                  controller.searchArticle(value);
                },
                decoration: InputDecoration(
                  hintText: 'Cari artikel...',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _filterButton("Terbaru", "terbaru"),
                    _filterButton("Populer", "populer"),
                    _filterButton("Terfavorit", "terfavorit"),
                    _filterButton("Paling Lama", "terlama"),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: Obx(
                  () {
                    if (controller.isLoading.value) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return _buildSkeletonArticleCard();
                        },
                      );
                    }
                    return controller.articles.isEmpty
                        ? const Center(child: Text('Tidak ada artikel'))
                        : RefreshIndicator(
                            onRefresh: () async {
                              controller.fetchArticles();
                            },
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: controller.articles.length,
                              itemBuilder: (context, index) {
                                final article = controller.articles[index];
                                return _buildArticleCard(article);
                              },
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonArticleCard() {
    return Skeletonizer(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding:
            const EdgeInsets.only(right: 18, left: 12, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Themes.backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      height: 16,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 200,
                      height: 12,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterButton(String label, String category) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: () => controller.updateFilter(category),
          style: ElevatedButton.styleFrom(
            backgroundColor: controller.selectedFilter.value == category
                ? Colors.green
                : const Color.fromARGB(255, 213, 213, 213),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily:
                  GoogleFonts.poppins(fontWeight: FontWeight.w500).fontFamily,
              color: controller.selectedFilter.value == category
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildArticleCard(Article article) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.ARTICLE_DETAIL, parameters: {
          'id': article.id!.toString(),
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.only(right: 18, left: 12, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Themes.backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  article.coverUrl!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      article.judul!,
                      style: TextStyle(
                        fontFamily:
                            GoogleFonts.poppins(fontWeight: FontWeight.w700)
                                .fontFamily,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Use HtmlWidget to render HTML content
                    Container(
                      constraints: BoxConstraints(maxHeight: 70),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: HtmlWidget(
                          article.shortDesc!,
                          textStyle: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
