import 'package:get/get.dart';
import 'package:gurkha_pasal/models/product.dart';

class ProductController extends GetxController {
  // Main product list
  var products = <Product>[].obs;

  // Exclusive deals list (discounted products)
  var exclusiveDeals = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void loadProducts() {
    products.assignAll([
      Product(
        id: "1",
        name: "Wireless Earbuds",
        description: "High-quality wireless earbuds with noise cancellation.",
        price: 49.99,
        imageUrl:
            "https://images.unsplash.com/photo-1606220588913-b3a1b480fc25",
        category: "Electronics",
        discount: 20,
      ),
      Product(
        id: "2",
        name: "Dumbbell Set",
        description: "Adjustable dumbbell set for home workouts.",
        price: 89.99,
        imageUrl:
            "https://images.unsplash.com/photo-1605296866985-34b1741b88b7",
        category: "Fitness",
        discount: 15,
      ),
      Product(
        id: "3",
        name: "Leather Jacket",
        description: "Stylish leather jacket for all seasons.",
        price: 129.99,
        imageUrl: "https://images.unsplash.com/photo-1551488831-00ddcb6c0b6d",
        category: "Clothing",
        discount: 10,
      ),
      Product(
        id: "4",
        name: "Smart Watch",
        description: "Smart watch with fitness tracking and notifications.",
        price: 199.99,
        imageUrl:
            "https://images.unsplash.com/photo-1617043985467-5a141f8961df",
        category: "Electronics",
        discount: 25,
      ),
      Product(
        id: "5",
        name: "Ceramic Mug",
        description: "Elegant ceramic mug for coffee or tea.",
        price: 9.99,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Home & Kitchen",
        discount: 0,
      ),
      Product(
        id: "6",
        name: "Running Shoes",
        description: "Comfortable running shoes for all terrains.",
        price: 59.99,
        imageUrl:
            "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa",
        category: "Footwear",
        discount: 30,
      ),
      Product(
        id: "7",
        name: "Backpack",
        description: "Durable backpack for travel and daily use.",
        price: 39.99,
        imageUrl: "https://images.unsplash.com/photo-1553062407-98eeb64c6a62",
        category: "Accessories",
        discount: 20,
      ),
      Product(
        id: "8",
        name: "Stainless Steel Kettle",
        description: "Electric stainless steel kettle with auto shut-off.",
        price: 29.99,
        imageUrl:
            "https://images.unsplash.com/photo-1571761953909-9d8a8d64e5e1",
        category: "Home & Kitchen",
        discount: 15,
      ),
      Product(
        id: "9",
        name: "Yoga Mat",
        description: "Non-slip yoga mat for all fitness levels.",
        price: 19.99,
        imageUrl:
            "https://images.unsplash.com/photo-1601925267869-02e43e951d2e",
        category: "Fitness",
        discount: 10,
      ),
      Product(
        id: "10",
        name: "Sunglasses",
        description: "UV-protective sunglasses with a sleek design.",
        price: 24.99,
        imageUrl:
            "https://images.unsplash.com/photo-1572635196237-14b3f281503f",
        category: "Accessories",
        discount: 25,
      ),
      Product(
        id: "11",
        name: "Laptop Stand",
        description: "Ergonomic laptop stand for better posture.",
        price: 34.99,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Electronics",
        discount: 20,
      ),
      Product(
        id: "12",
        name: "Coffee Maker",
        description: "Automatic coffee maker for fresh brews.",
        price: 79.99,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Home & Kitchen",
        discount: 15,
      ),
      Product(
        id: "13",
        name: "T-Shirt",
        description: "Comfortable cotton T-shirt for casual wear.",
        price: 14.99,
        imageUrl:
            "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab",
        category: "Clothing",
        discount: 10,
      ),
      Product(
        id: "14",
        name: "Bluetooth Speaker",
        description: "Portable Bluetooth speaker with high-quality sound.",
        price: 44.99,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Electronics",
        discount: 25,
      ),
      Product(
        id: "15",
        name: "Desk Lamp",
        description: "Adjustable desk lamp with LED lighting.",
        price: 29.99,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Home & Kitchen",
        discount: 20,
      ),
      Product(
        id: "16",
        name: "Sneakers",
        description: "Stylish sneakers for everyday wear.",
        price: 69.99,
        imageUrl:
            "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa",
        category: "Footwear",
        discount: 15,
      ),
      Product(
        id: "17",
        name: "Wallet",
        description: "Leather wallet with multiple compartments.",
        price: 19.99,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Accessories",
        discount: 10,
      ),
      Product(
        id: "18",
        name: "Exercise Bike",
        description: "Stationary exercise bike for home fitness.",
        price: 299.99,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Fitness",
        discount: 30,
      ),
      Product(
        id: "19",
        name: "Headphones",
        description: "Over-ear headphones with deep bass.",
        price: 59.99,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Electronics",
        discount: 20,
      ),
      Product(
        id: "20",
        name: "Kitchen Knife Set",
        description: "Professional kitchen knife set with wooden block.",
        price: 49.99,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Home & Kitchen",
        discount: 15,
      ),
    ]);
  }
}
