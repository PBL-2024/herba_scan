class FavoriteItem {
  final int id;
  final String imgPath;
  final String title;
  final String description;
  final String type;

  FavoriteItem({
    required this.id,
    required this.imgPath,
    required this.title,
    required this.description,
    required this.type,
  });

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'],
      imgPath: json['imgPath'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imgPath': imgPath,
      'title': title,
      'description': description,
      'type': type,
    };
  }
}