// To parse this JSON data, do
//
//     final plantResponse = plantResponseFromJson(jsonString);

import 'dart:convert';

PlantResponse plantResponseFromJson(String str) => PlantResponse.fromJson(json.decode(str));

String plantResponseToJson(PlantResponse data) => json.encode(data.toJson());

class PlantResponse {
  final bool? success;
  final List<Plant>? data;
  final String? message;

  PlantResponse({
    this.success,
    this.data,
    this.message,
  });

  factory PlantResponse.fromJson(Map<String, dynamic> json) => PlantResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<Plant>.from(json["data"]!.map((x) => Plant.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
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
  final int? favoritesCount;
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
    this.favoritesCount,
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
    favoritesCount: json["favorites_count"],
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
    "favorites_count": favoritesCount,
    "cover_url": coverUrl,
  };
}

SinglePlantResponse singlePlantResponseFromJson(String str) => SinglePlantResponse.fromJson(json.decode(str));

String singlePlantResponseToJson(SinglePlantResponse data) => json.encode(data.toJson());

class SinglePlantResponse {
  final bool? success;
  final Plant? data;
  final String? message;

  SinglePlantResponse({
    this.success,
    this.data,
    this.message,
  });

  factory SinglePlantResponse.fromJson(Map<String, dynamic> json) => SinglePlantResponse(
    success: json["success"],
    data: json["data"] == null ? null : Plant.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

PlantFavorite plantFavoriteFromJson(String str) => PlantFavorite.fromJson(json.decode(str));

String plantFavoriteToJson(PlantFavorite data) => json.encode(data.toJson());

class PlantFavorite {
  final bool? success;
  final bool? data;
  final String? message;

  PlantFavorite({
    this.success,
    this.data,
    this.message,
  });

  factory PlantFavorite.fromJson(Map<String, dynamic> json) => PlantFavorite(
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
