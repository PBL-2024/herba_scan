// To parse this JSON data, do
//
//     final plantSuggestionListResponse = plantSuggestionListResponseFromJson(jsonString);

import 'dart:convert';

PlantSuggestionListResponse plantSuggestionListResponseFromJson(String str) => PlantSuggestionListResponse.fromJson(json.decode(str));

String plantSuggestionListResponseToJson(PlantSuggestionListResponse data) => json.encode(data.toJson());

class PlantSuggestionListResponse {
  final bool? success;
  final List<String>? data;
  final String? message;

  PlantSuggestionListResponse({
    this.success,
    this.data,
    this.message,
  });

  factory PlantSuggestionListResponse.fromJson(Map<String, dynamic> json) => PlantSuggestionListResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<String>.from(json["data"]!.map((x) => x)),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
    "message": message,
  };
}
