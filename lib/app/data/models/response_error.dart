// To parse this JSON data, do
//
//     final responseError = responseErrorFromJson(jsonString);

import 'dart:convert';

ResponseError responseErrorFromJson(String str) => ResponseError.fromJson(json.decode(str));

String responseErrorToJson(ResponseError data) => json.encode(data.toJson());

class ResponseError {
  final bool success;
  final String message;
  final Error data;

  ResponseError({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResponseError.fromJson(Map<String, dynamic> json) => ResponseError(
    success: json["success"],
    message: json["message"],
    data: Error.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Error {
  final String error;

  Error({
    required this.error,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
  };
}
