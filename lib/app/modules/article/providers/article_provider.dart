// ignore_for_file: unused_import

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:herba_scan/config.dart';

class ArticleProvider extends GetConnect {
  @override
  void onInit() {
    // Validasi base URL
    if (Config.BACKEND_API_URL.isEmpty) {
      if (kDebugMode) {
        print('Error: Config.BACKEND_API_URL is not set.');
      }
    }
    final box = GetStorage();
    httpClient.baseUrl = Config.BACKEND_API_URL;
    httpClient.addRequestModifier<Object?>((request) {
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer ${box.read('token')}';
      return request;
    });
    httpClient.timeout = const Duration(seconds: 30);
  }

  Future<Response> fetchArticles({String filter = 'terbaru'}) async {
    String endpoint = '/api/v1/articles?filter=$filter';

    try {
      final response = await get(endpoint);

      if (response.statusCode == 200) {
        return response;
      } else {
        if (kDebugMode) {
          debugPrint('Error during fetchArticles: ${response.bodyString}');
        }
        return response;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during fetchArticles: $e');
      }
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
          "komentar": comment,
        },
        contentType: 'application/json',
        headers: {'Accept': 'application/json'},
      );

  /// Menghapus komentar berdasarkan ID
  Future<Response> deleteComment(String articleId, String commentId) async {
    final url = '/api/v1/article/comment/$articleId/$commentId';
    final res = await delete(
      url,
      headers: {'Accept': 'application/json'},
    );

    return res;
  }

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
