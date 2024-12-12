// To parse this JSON data, do
//
//     final userFavorites = userFavoritesFromJson(jsonString);

import 'dart:convert';

UserFavorites userFavoritesFromJson(String str) => UserFavorites.fromJson(json.decode(str));

String userFavoritesToJson(UserFavorites data) => json.encode(data.toJson());

class UserFavorites {
  final bool? success;
  final Data? data;
  final String? message;

  UserFavorites({
    this.success,
    this.data,
    this.message,
  });

  factory UserFavorites.fromJson(Map<String, dynamic> json) => UserFavorites(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  final List<Plant>? plants;
  final List<Article>? articles;

  Data({
    this.plants,
    this.articles,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    plants: json["plants"] == null ? [] : List<Plant>.from(json["plants"]!.map((x) => Plant.fromJson(x))),
    articles: json["articles"] == null ? [] : List<Article>.from(json["articles"]!.map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "plants": plants == null ? [] : List<dynamic>.from(plants!.map((x) => x.toJson())),
    "articles": articles == null ? [] : List<dynamic>.from(articles!.map((x) => x.toJson())),
  };
}

class Article {
  final int? id;
  final int? userId;
  final String? judul;
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
    "isi": isi,
    "cover": cover,
    "total_view": totalView,
    "tanggal_publikasi": "${tanggalPublikasi!.year.toString().padLeft(4, '0')}-${tanggalPublikasi!.month.toString().padLeft(2, '0')}-${tanggalPublikasi!.day.toString().padLeft(2, '0')}",
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "cover_url": coverUrl,
  };
}

class Plant {
  final int? id;
  final int? userId;
  final String? nama;
  final String? cover;
  final String? deskripsi;
  final String? manfaat;
  final String? pengolahan;
  final int? totalView;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? coverUrl;

  Plant({
    this.id,
    this.userId,
    this.nama,
    this.cover,
    this.deskripsi,
    this.manfaat,
    this.pengolahan,
    this.totalView,
    this.createdAt,
    this.updatedAt,
    this.coverUrl,
  });

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
    id: json["id"],
    userId: json["user_id"],
    nama: json["nama"],
    cover: json["cover"],
    deskripsi: json["deskripsi"],
    manfaat: json["manfaat"],
    pengolahan: json["pengolahan"],
    totalView: json["total_view"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    coverUrl: json["cover_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "nama": nama,
    "cover": cover,
    "deskripsi": deskripsi,
    "manfaat": manfaat,
    "pengolahan": pengolahan,
    "total_view": totalView,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "cover_url": coverUrl,
  };
}
