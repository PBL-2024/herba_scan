// To parse this JSON data, do
//
//     final faqResponse = faqResponseFromJson(jsonString);

import 'dart:convert';

FaqResponse faqResponseFromJson(String str) => FaqResponse.fromJson(json.decode(str));

String faqResponseToJson(FaqResponse data) => json.encode(data.toJson());

class FaqResponse {
  final bool success;
  final List<Faq> data;
  final String message;

  FaqResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory FaqResponse.fromJson(Map<String, dynamic> json) => FaqResponse(
    success: json["success"],
    data: List<Faq>.from(json["data"].map((x) => Faq.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class Faq {
  final int id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  Faq({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
