// To parse this JSON data, do
//
//     final userFavorites = userFavoritesFromJson(jsonString);

import 'dart:convert';

import 'package:herba_scan/app/data/models/plant_response.dart';
import 'package:herba_scan/app/data/models/response_article.dart';

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