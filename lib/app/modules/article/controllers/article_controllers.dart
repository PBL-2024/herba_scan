import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:herba_scan/app/data/models/response_article.dart';
import 'package:herba_scan/app/data/models/response_article_comment.dart';
import 'package:herba_scan/app/data/models/riwayat_item.dart';
import 'package:herba_scan/app/modules/article/providers/article_provider.dart';
import 'package:herba_scan/app/modules/home/controllers/home_controller.dart';
import 'package:herba_scan/app/modules/home/controllers/user_controller.dart';
import 'package:herba_scan/config.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class ArticleController extends GetxController {
  final ArticleProvider _articleProvider = Get.find<ArticleProvider>();
  final isLoading = true.obs;
  final sendCommentLoading = false.obs;
  final isFavorite = false.obs;
  final RxList<Article> articles = <Article>[].obs;
  final RxList<Comment> comments = <Comment>[].obs;
  final filteredArticles = RxList<Map<String, dynamic>>([]);
  final selectedFilter = 'terbaru'.obs;
  final articleTitle = ''.obs;
  final selectedArticle = Article().obs;
  final commentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }

  /// Mengambil daftar artikel dari provider
  void fetchArticles() {
    isLoading.value = true;
    _articleProvider
        .fetchArticles()
        .then(
          (value) {
            if (value.statusCode == 200) {
              final response = articleResponseFromJson(value.bodyString!);
              articles.value = response.data!;
            }
          },
        )
        .whenComplete(() => isLoading.value = false)
        .onError(
          (error, stackTrace) {
            isLoading.value = false;
            if (kDebugMode) {
              debugPrint('Error: $error');
            }
          },
        );
  }

  /// Memperbarui filter berdasarkan kategori
  void updateFilter(String filter) {
    selectedFilter.value = filter;

    _articleProvider
        .fetchArticles(filter: filter)
        .then(
          (value) {
            if (value.statusCode == 200) {
              final response = articleResponseFromJson(value.bodyString!);
              articles.value = response.data!;
            }
          },
        )
        .whenComplete(() => isLoading.value = false)
        .onError(
          (error, stackTrace) {
            isLoading.value = false;
            if (kDebugMode) {
              debugPrint('Error: $error');
            }
          },
        );
  }

  void searchArticle(String keyword) {
    isLoading.value = true;
    if (keyword.isEmpty) {
      fetchArticles();
      return;
    }
    _articleProvider
        .searchArticles(keyword)
        .then(
          (value) {
            if (value.statusCode == 200) {
              final response = articleResponseFromJson(value.bodyString!);
              articles.value = response.data!;
            }
          },
        )
        .whenComplete(() => isLoading.value = false)
        .onError(
          (error, stackTrace) {
            isLoading.value = false;
            if (kDebugMode) {
              debugPrint('Error: $error');
            }
          },
        );
  }

  void getArticleById(String articleId) {
    isLoading.value = true;
    _articleProvider.getArticleById(articleId).then(
      (value) {
        if (value.statusCode == 200) {
          final response = singleArticleResponseFromJson(value.bodyString!);
          selectedArticle.value = response.data!;
          final RiwayatItem item = RiwayatItem(
            id: response.data!.id!,
            title: response.data!.judul!,
            imgPath: response.data!.coverUrl!,
            description: response.data!.shortDesc!,
            type: "artikel",
            hash: DateTime.now().hashCode,
          );
          final homeController = Get.find<HomeController>();
          homeController.setRiwayat(item);
        }
      },
    ).onError(
      (error, stackTrace) {
        if (kDebugMode) {
          debugPrint('Error: $error');
        }
      },
    ).whenComplete(() => isLoading.value = false);
  }

  void isFavoriteArticle(String articleId) {
    _articleProvider.isFavorite(articleId).then(
      (value) {
        if (value.statusCode == 200) {
          isFavorite.value = articleFavoriteFromJson(value.bodyString!).data!;
        }
      },
    ).onError(
      (error, stackTrace) {
        if (kDebugMode) {
          debugPrint('Error: $error');
        }
      },
    );
  }

  void addFavoriteArticle(String articleId) {
    final userController = Get.find<UserController>();
    if (!userController.checkToken()) {
      userController.confirmAuth();
      return;
    }
    _articleProvider.markAsFavorite(articleId).then(
      (value) {
        if (value.statusCode == 200) {
          final homeController = Get.find<HomeController>();
          final response = articleFavoriteFromJson(value.bodyString!);
          Get.snackbar('Berhasil', response.message!,duration: const Duration(seconds: 1));
          homeController.getFavorites();
          isFavoriteArticle(articleId);
        }
      },
    ).onError((error, stackTrace) {
      if (kDebugMode) {
        debugPrint('Error: $error');
      }
    });
  }

  void fetchComments(String articleId) {
    _articleProvider.getComments(articleId).then(
      (value) {
        if (value.statusCode == 200) {
          final response = responseArticleCommentFromJson(value.bodyString!);
          comments.value = response.data!;
        }
      },
    ).onError((error, stackTrace) {
      if (kDebugMode) {
        debugPrint('Error: $error');
      }
    });
  }

  String formatDate(DateTime parse) {
    final now = DateTime.now();
    final difference = now.difference(parse);

    if (difference.inDays > 8) {
      return DateFormat('dd MMM yyyy').format(parse);
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} hari yang lalu';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} menit yang lalu';
    } else {
      return 'baru saja';
    }
  }

  void sendComment(String articleId, String comment) {
    final userController = Get.find<UserController>();
    if (!userController.checkToken()) {
      userController.confirmAuth();
      return;
    }
    // check if comment is empty
    if (comment.isEmpty) {
      Get.snackbar('Gagal', 'Komentar tidak boleh kosong');
      return;
    }
    sendCommentLoading.value = true;
    _articleProvider.addComment(articleId, comment).then(
      (value) {
        if (value.statusCode == 200) {
          Get.snackbar('Berhasil', 'Komentar berhasil ditambahkan',
              duration: const Duration(seconds: 1));
          commentController.clear();
          fetchComments(articleId);
        } else {
          Get.snackbar('Gagal', 'Gagal mengirim komentar',
              duration: const Duration(seconds: 1));
          if (kDebugMode) {
            debugPrint('Error: ${value.bodyString}');
          }
        }
        sendCommentLoading.value = false;
      },
    ).onError((error, stackTrace) {
      if (kDebugMode) {
        debugPrint('Error: $error');
      }
      sendCommentLoading.value = false;
    });
  }

  void showDialogDeleteComment(String articleId, String commentId) {
    Get.defaultDialog(
      title: 'Hapus Komentar',
      middleText: 'Apakah Anda yakin ingin menghapus komentar ini?',
      textConfirm: 'Ya',
      textCancel: 'Tidak',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () async {
        deleteComment(articleId, commentId);
        Get.back();
        await Future.delayed(const Duration(seconds: 1));
        Get.back();
      },
      onWillPop: () async {
        return true;
      },
    );
  }

  void deleteComment(String articleId, String commentId) {
    _articleProvider.deleteComment(articleId, commentId).then(
      (value) {
        if (value.statusCode == 200) {
          Get.snackbar('Berhasil', 'Komentar berhasil dihapus',
              duration: const Duration(seconds: 1));
          fetchComments(articleId);
        } else {
          Get.snackbar('Gagal', 'Gagal menghapus komentar',
              duration: const Duration(seconds: 1));
          if (kDebugMode) {
            debugPrint('Error: ${value.bodyString}');
          }
        }
      },
    ).onError((error, stackTrace) {
      if (kDebugMode) {
        debugPrint('Error: $error');
      }
    });
  }

  void shareArticle(Article article) {
    final link = '${Config.APP_URL}/article-detail?id=${article.id}';
    Share.share(
      '${article.judul}\n\n$link',
      subject: article.judul,
    );
  }
}
