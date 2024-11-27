import 'package:get/get.dart';

class ArticleProvider {
  Future<List<Map<String, String>>> fetchArticles() async {
    // Simulasi mengambil data artikel dari sumber eksternal
    await Future.delayed(Duration(seconds: 2)); // Simulasi delay
    return [
      {
        "title": "Daun Kemangi Bisa Buat Kaya Lho...",
        "description": "Daun Kemangi kaya manfaat...",
        "imageUrl": "assets/images/kemangi.png",
      },
      {
        "title": "Aloe Vera untuk Kesehatan Kulit...",
        "description": "Aloe Vera memberikan banyak manfaat...",
        "imageUrl": "assets/images/aloe_vera.png",
      }
    ];
  }
}
