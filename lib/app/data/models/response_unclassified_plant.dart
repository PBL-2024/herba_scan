// To parse this JSON data, do
//
//     final unclassifiedPlantResponse = unclassifiedPlantResponseFromJson(jsonString);

import 'dart:convert';

UnclassifiedPlantResponse unclassifiedPlantResponseFromJson(String str) =>
    UnclassifiedPlantResponse.fromJson(json.decode(str));

String unclassifiedPlantResponseToJson(UnclassifiedPlantResponse data) =>
    json.encode(data.toJson());

class UnclassifiedPlantResponse {
  final bool? success;
  final List<Plant>? data;
  final String? message;

  UnclassifiedPlantResponse({
    this.success,
    this.data,
    this.message,
  });

  factory UnclassifiedPlantResponse.fromJson(Map<String, dynamic> json) =>
      UnclassifiedPlantResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Plant>.from(json["data"]!.map((x) => Plant.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Plant {
  final int? id;
  final int? userId;
  final String? nama;
  final String? file;
  final int? isVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? fileUrl;

  Plant({
    this.id,
    this.userId,
    this.nama,
    this.file,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
    this.fileUrl,
  });

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
        id: json["id"],
        userId: json["user_id"],
        nama: json["nama"],
        file: json["file"],
        isVerified: json["is_verified"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        fileUrl: json["file_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "nama": nama,
        "file": file,
        "is_verified": isVerified,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "file_url": fileUrl,
      };
}
