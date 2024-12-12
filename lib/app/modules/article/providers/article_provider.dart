import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:herba_scan/config.dart';

class ArticleProvider extends GetConnect {
  @override
  void onInit() {
    // Validasi base URL
    if (Config.BACKEND_API_URL.isEmpty) {
      print('Error: Config.BACKEND_API_URL is not set.');
    }

    httpClient.baseUrl = Config.BACKEND_API_URL;
    httpClient.timeout = const Duration(seconds: 30);

    print('Initialized with baseUrl: ${httpClient.baseUrl}');
  }

  /// Mengambil daftar artikel
  Future<Response> fetchArticles() async {
    const endpoint = '/api/v1/articles';

    try {
      print('Fetching articles from endpoint: ${httpClient.baseUrl}$endpoint');
      final response = await get(endpoint);

      if (response.statusCode == 200) {
        print('Fetch successful: ${response.body}');
        return response;
      } else {
        print(
            'Fetch failed: Status ${response.statusCode}, Body: ${response.body}');
        return response;
      }
    } catch (e) {
      print('Error during fetchArticles: $e');
      return Response(statusCode: null, body: null);
    }
  }

  /// Mengambil artikel berdasarkan ID
  Future<Response> getArticleById(String articleId) => get(
        '/api/v1/article/$articleId',
        headers: {'Accept': 'application/json'},
      );

  /// Mencari artikel berdasarkan keyword
  Future<Response> searchArticles(String keyword) => get(
        '/api/v1/article/search/$keyword',
        headers: {'Accept': 'application/json'},
      );

  /// Mengambil komentar berdasarkan ID artikel
  Future<Response> getComments(String articleId) => get(
        '/api/v1/article/comment/$articleId',
        headers: {'Accept': 'application/json'},
      );

  /// Menambahkan komentar pada artikel tertentu
  Future<Response> addComment(String articleId, String comment) => post(
        '/api/v1/article/comment',
        {
          "article_id": articleId,
          "comment": comment,
        },
        contentType: 'application/json',
        headers: {'Accept': 'application/json'},
      );

  /// Menghapus komentar berdasarkan ID
  Future<Response> deleteComment(String commentId) => delete(
        '/api/v1/article/comment/$commentId',
        headers: {'Accept': 'application/json'},
      );

  /// Menandai artikel sebagai favorit
  Future<Response> markAsFavorite(String articleId) => post(
        '/api/v1/article/favorite',
        {"article_id": articleId},
        contentType: 'application/json',
        headers: {'Accept': 'application/json'},
      );

  /// Mengecek apakah artikel sudah ditandai sebagai favorit
  Future<Response> isFavorite(String articleId) => post(
        '/api/v1/article/is-favorite',
        {"article_id": articleId},
        contentType: 'application/json',
        headers: {'Accept': 'application/json'},
      );
}
