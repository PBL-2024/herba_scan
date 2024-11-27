// To parse this JSON data, do
//
//     final responseError = responseErrorFromJson(jsonString);

import 'dart:convert';

ResponseError responseErrorFromJson(String str) => ResponseError.fromJson(json.decode(str));

String responseErrorToJson(ResponseError data) => json.encode(data.toJson());

class ResponseError {
  final bool success;
  final String message;
  final Data data;

  ResponseError({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResponseError.fromJson(Map<String, dynamic> json) => ResponseError(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final String error;

  Data({
    required this.error,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
  };
}
