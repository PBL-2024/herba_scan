import 'package:flutter/material.dart';
import 'detail_article_view.dart';
import 'package:get/get.dart';
import 'package:herba_scan/app/modules/article/controllers/article_controllers.dart';

class ArticleView extends GetView<ArticleController> {
  const ArticleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Artikel Kesehatan'),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => controller.articleTitle.value = value,
                  decoration: InputDecoration(
                    hintText: 'Cari artikel...',
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                
                // Filter Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _filterButton("Terbaru", "terbaru"),
                    _filterButton("Populer", "populer"),
                    _filterButton("Paling Lama", "paling lama"),
                  ],
                ),
                const SizedBox(height: 16.0),

                // Article List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.articles.length,
                  itemBuilder: (context, index) {
                    final article = controller.articles[index];
                    return _articleCard(article);
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _filterButton(String label, String category) {
    return Obx(() => ElevatedButton(
      onPressed: () => controller.selectedFilter.value = category,
      style: ElevatedButton.styleFrom(
        backgroundColor: controller.selectedFilter.value == category
            ? Colors.green
            : const Color.fromARGB(255, 213, 213, 213),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: controller.selectedFilter.value == category
              ? Colors.white
              : Colors.black,
        ),
      ),
    ));
  }

  Widget _articleCard(Map<String, String> article) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: const Color(0xFFE7F9E0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Get.to(() => ArticleDetailView(
                title: article['title']!,
                content: article['description']!,
                imageUrl: article['imageUrl']!,
              ));
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                article['imageUrl']!,
                width: 150,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article['title']!,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    article['description']!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}