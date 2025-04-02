class Review {
  final String userId;
  final String comment;
  final double rating;

  Review({required this.userId, required this.comment, required this.rating});

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'comment': comment, 'rating': rating};
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      userId: map['userId'] ?? '',
      comment: map['comment'] ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String category;
  final double? originalPrice;
  final int? discount;
  final List<String> colors;
  final List<String> storageOptions;
  final List<String> sizes;
  final bool isNew;
  final double? rating;
  final int? stock;
  final int? soldCount; // Added for sold count
  final List<Review>? reviews; // Added for reviews
  final bool isExclusiveDeal;
  final DateTime? dealEndTime;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.category,
    this.originalPrice,
    this.discount,
    required this.colors,
    required this.storageOptions,
    this.sizes = const [],
    this.isNew = false,
    this.rating,
    this.stock,
    this.soldCount,
    this.reviews,
    this.isExclusiveDeal = false,
    this.dealEndTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'category': category,
      'originalPrice': originalPrice,
      'discount': discount,
      'colors': colors,
      'storageOptions': storageOptions,
      'sizes': sizes,
      'isNew': isNew,
      'rating': rating,
      'stock': stock,
      'soldCount': soldCount,
      'reviews': reviews?.map((review) => review.toMap()).toList(),
      'isExclusiveDeal': isExclusiveDeal,
      'dealEndTime': dealEndTime?.toIso8601String(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      originalPrice: (map['originalPrice'] as num?)?.toDouble(),
      discount: map['discount'] as int?,
      colors: List<String>.from(map['colors'] ?? []),
      storageOptions: List<String>.from(map['storageOptions'] ?? []),
      sizes: List<String>.from(map['sizes'] ?? []),
      isNew: map['isNew'] ?? false,
      rating: (map['rating'] as num?)?.toDouble(),
      stock: map['stock'] as int?,
      soldCount: map['soldCount'] as int?,
      reviews:
          map['reviews'] != null
              ? (map['reviews'] as List)
                  .map((reviewMap) => Review.fromMap(reviewMap))
                  .toList()
              : null,
      isExclusiveDeal: map['isExclusiveDeal'] ?? false,
      dealEndTime:
          map['dealEndTime'] != null
              ? DateTime.parse(map['dealEndTime'])
              : null,
    );
  }
}
