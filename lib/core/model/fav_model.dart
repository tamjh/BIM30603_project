class FavModel {
  List<Favourite> favourite = [];

  FavModel({required this.favourite});

  factory FavModel.fromJson(Map<String, dynamic> json) {
    return FavModel(
      favourite: (json['favourite'] as List)
          .map((item) => Favourite.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'favourite': favourite.map((fav) => fav.toJson()).toList(),
    };
  }
}

class Favourite {
  String productId;
  DateTime createdAt;

  Favourite({
    required this.productId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Favourite.fromJson(Map<String, dynamic> json) {
    return Favourite(
      productId: json['productId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
