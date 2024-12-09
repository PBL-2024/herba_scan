class RiwayatItem {
  final int id;
  final String imgPath;
  final String title;
  final String description;
  final String type;
  final int hash;

  RiwayatItem({
    required this.id,
    required this.imgPath,
    required this.title,
    required this.description,
    required this.type,
    required this.hash,
  });

  factory RiwayatItem.fromJson(Map<String, dynamic> json) {
    return RiwayatItem(
      id: json['id'],
      imgPath: json['imgPath'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      hash: json['hash'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imgPath': imgPath,
      'title': title,
      'description': description,
      'type': type,
      'hash': hash,
    };
  }
}