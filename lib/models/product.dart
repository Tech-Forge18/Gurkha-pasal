class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String category;
  final double? originalPrice;
  final int? discount;
  final List<String> colors; // List of available colors
  // List of available RAM options
  final List<String> storageOptions;

  // List of available storage options

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
  });

  // Convert Product to Map for cart usage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'originalPrice': originalPrice,
      'discount': discount,
      'colors': colors,
      'storageOptions': storageOptions,
    };
  }
}
