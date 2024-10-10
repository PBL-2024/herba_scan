// To parse this JSON data, do
//
//     final prediction = predictionFromJson(jsonString);

import 'dart:convert';

Prediction predictionFromJson(String str) => Prediction.fromJson(json.decode(str));

String predictionToJson(Prediction data) => json.encode(data.toJson());

class Prediction {
  final List<Image> images;
  final Metadata metadata;

  Prediction({
    required this.images,
    required this.metadata,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    metadata: Metadata.fromJson(json["metadata"]),
  );

  Map<String, dynamic> toJson() => {
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "metadata": metadata.toJson(),
  };
}

class Image {
  final List<Result> results;
  final List<int> shape;
  final Speed speed;

  Image({
    required this.results,
    required this.shape,
    required this.speed,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    shape: List<int>.from(json["shape"].map((x) => x)),
    speed: Speed.fromJson(json["speed"]),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "shape": List<dynamic>.from(shape.map((x) => x)),
    "speed": speed.toJson(),
  };
}

class Result {
  final int resultClass;
  final double confidence;
  final String name;

  Result({
    required this.resultClass,
    required this.confidence,
    required this.name,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    resultClass: json["class"],
    confidence: json["confidence"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "class": resultClass,
    "confidence": confidence,
    "name": name,
  };
}

class Speed {
  final double inference;
  final double postprocess;
  final double preprocess;

  Speed({
    required this.inference,
    required this.postprocess,
    required this.preprocess,
  });

  factory Speed.fromJson(Map<String, dynamic> json) => Speed(
    inference: json["inference"]?.toDouble(),
    postprocess: json["postprocess"]?.toDouble(),
    preprocess: json["preprocess"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "inference": inference,
    "postprocess": postprocess,
    "preprocess": preprocess,
  };
}

class Metadata {
  final double functionTimeAlive;
  final double functionTimeCall;
  final int imageCount;
  final String model;
  final Version version;

  Metadata({
    required this.functionTimeAlive,
    required this.functionTimeCall,
    required this.imageCount,
    required this.model,
    required this.version,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    functionTimeAlive: json["functionTimeAlive"]?.toDouble(),
    functionTimeCall: json["functionTimeCall"]?.toDouble(),
    imageCount: json["imageCount"],
    model: json["model"],
    version: Version.fromJson(json["version"]),
  );

  Map<String, dynamic> toJson() => {
    "functionTimeAlive": functionTimeAlive,
    "functionTimeCall": functionTimeCall,
    "imageCount": imageCount,
    "model": model,
    "version": version.toJson(),
  };
}

class Version {
  final String python;
  final String torch;
  final String torchvision;
  final String ultralytics;

  Version({
    required this.python,
    required this.torch,
    required this.torchvision,
    required this.ultralytics,
  });

  factory Version.fromJson(Map<String, dynamic> json) => Version(
    python: json["python"],
    torch: json["torch"],
    torchvision: json["torchvision"],
    ultralytics: json["ultralytics"],
  );

  Map<String, dynamic> toJson() => {
    "python": python,
    "torch": torch,
    "torchvision": torchvision,
    "ultralytics": ultralytics,
  };
}
