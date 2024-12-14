// To parse this JSON data, do
//
//     final Auth = AuthFromJson(jsonString);

import 'dart:convert';

Auth authFromJson(String str) => Auth.fromJson(json.decode(str));

String authToJson(Auth data) => json.encode(data.toJson());

class Auth {
  final bool success;
  final Data data;
  final String message;

  Auth({
    required this.success,
    required this.data,
    required this.message,
  });

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
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
