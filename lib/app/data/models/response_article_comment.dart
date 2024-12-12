import 'dart:convert';

ResponseArticleComment responseArticleCommentFromJson(String str) => ResponseArticleComment.fromJson(json.decode(str));

String responseArticleCommentToJson(ResponseArticleComment data) => json.encode(data.toJson());

class ResponseArticleComment {
  final bool? success;
  final List<Comment>? data;
  final String? message;

  ResponseArticleComment({
    this.success,
    this.data,
    this.message,
  });

  factory ResponseArticleComment.fromJson(Map<String, dynamic> json) => ResponseArticleComment(
    success: json["success"],
    data: json["data"] == null ? [] : List<Comment>.from(json["data"]!.map((x) => Comment.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Comment {
  final int? id;
  final String? komentar;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? myComment;
  final User? user;

  Comment({
    this.id,
    this.komentar,
    this.createdAt,
    this.updatedAt,
    this.myComment,
    this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    komentar: json["komentar"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    myComment: json["my_comment"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "komentar": komentar,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "my_comment": myComment,
    "user": user?.toJson(),
  };
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final dynamic emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic googleId;
  final String? imageUrl;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.googleId,
    this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
