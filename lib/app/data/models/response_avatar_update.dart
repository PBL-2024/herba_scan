// To parse this JSON data, do
//
//     final avatarUpdateResponse = avatarUpdateResponseFromJson(jsonString);

import 'dart:convert';

AvatarUpdateResponse avatarUpdateResponseFromJson(String str) =>
    AvatarUpdateResponse.fromJson(json.decode(str));

String avatarUpdateResponseToJson(AvatarUpdateResponse data) =>
    json.encode(data.toJson());

class AvatarUpdateResponse {
  final bool? success;
  final Data? data;
  final String? message;

  AvatarUpdateResponse({
    this.success,
    this.data,
    this.message,
  });

  factory AvatarUpdateResponse.fromJson(Map<String, dynamic> json) =>
      AvatarUpdateResponse(
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
  final int? id;
  final String? name;
  final String? email;
  final dynamic emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic googleId;
  final String? imageUrl;

  Data({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.googleId,
    this.imageUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        googleId: json["google_id"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "google_id": googleId,
        "image_url": imageUrl,
      };
}
