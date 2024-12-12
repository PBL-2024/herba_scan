// To parse this JSON data, do
//
//     final articleResponse = articleResponseFromJson(jsonString);

import 'dart:convert';

ArticleResponse articleResponseFromJson(String str) => ArticleResponse.fromJson(json.decode(str));

String articleResponseToJson(ArticleResponse data) => json.encode(data.toJson());

class ArticleResponse {
  final bool? success;
  final List<Article>? data;
  final String? message;

  ArticleResponse({
    this.success,
    this.data,
    this.message,
  });

  factory ArticleResponse.fromJson(Map<String, dynamic> json) => ArticleResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<Article>.from(json["data"]!.map((x) => Article.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Article {
  final int? id;
  final int? userId;
  final String? judul;
  final String? shortDesc;
  final String? isi;
  final String? cover;
  final int? totalView;
  final DateTime? tanggalPublikasi;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? coverUrl;

  Article({
    this.id,
    this.userId,
    this.judul,
    this.shortDesc,
    this.isi,
    this.cover,
    this.totalView,
    this.tanggalPublikasi,
    this.createdAt,
    this.updatedAt,
    this.coverUrl,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    id: json["id"],
    userId: json["user_id"],
    judul: json["judul"],
    shortDesc: json["short_desc"],
    isi: json["isi"],
    cover: json["cover"],
    totalView: json["total_view"],
    tanggalPublikasi: json["tanggal_publikasi"] == null ? null : DateTime.parse(json["tanggal_publikasi"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    coverUrl: json["cover_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "judul": judul,
    "short_desc": shortDesc,
    "isi": isi,
    "cover": cover,
    "total_view": totalView,
    "tanggal_publikasi": "${tanggalPublikasi!.year.toString().padLeft(4, '0')}-${tanggalPublikasi!.month.toString().padLeft(2, '0')}-${tanggalPublikasi!.day.toString().padLeft(2, '0')}",
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "cover_url": coverUrl,
  };
}

SingleArticleResponse singleArticleResponseFromJson(String str) => SingleArticleResponse.fromJson(json.decode(str));

String singleArticleResponseToJson(SingleArticleResponse data) => json.encode(data.toJson());

class SingleArticleResponse {
  final bool? success;
  final Article? data;
  final String? message;

  SingleArticleResponse({
    this.success,
    this.data,
    this.message,
  });

  factory SingleArticleResponse.fromJson(Map<String, dynamic> json) => SingleArticleResponse(
    success: json["success"],
    data: json["data"] == null ? null : Article.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

ArticleFavorite articleFavoriteFromJson(String str) => ArticleFavorite.fromJson(json.decode(str));

String articleFavoriteToJson(ArticleFavorite data) => json.encode(data.toJson());

class ArticleFavorite {
  final bool? success;
  final bool? data;
  final String? message;

  ArticleFavorite({
    this.success,
    this.data,
    this.message,
  });

  factory ArticleFavorite.fromJson(Map<String, dynamic> json) => ArticleFavorite(
    success: json["success"],
    data: json["data"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data,
    "message": message,
  };
}
