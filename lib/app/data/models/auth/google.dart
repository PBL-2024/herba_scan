// To parse this JSON data, do
//
//     final googleAuth = googleAuthFromJson(jsonString);

import 'dart:convert';

GoogleAuth googleAuthFromJson(String str) => GoogleAuth.fromJson(json.decode(str));

String googleAuthToJson(GoogleAuth data) => json.encode(data.toJson());

class GoogleAuth {
  final bool success;
  final Data data;
  final String message;

  GoogleAuth({
    required this.success,
    required this.data,
    required this.message,
  });

  factory GoogleAuth.fromJson(Map<String, dynamic> json) => GoogleAuth(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  final String token;
  final String name;

  Data({
    required this.token,
    required this.name,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "name": name,
  };
}
