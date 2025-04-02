import 'package:get/get.dart';
import 'package:gurkha_pasal/models/product.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var exclusiveDeals = <Product>[].obs;
  var newArrivals = <Product>[].obs;
  var filteredProducts = <Product>[].obs; // For search functionality
  var categories = <String>[].obs; // For category chips and "Shop by Category"
  var isLoading = false.obs;

  // Getter for featured products (products with the highest discount)
  List<Product> get featuredProducts {
    return products
        .where((product) => product.discount != null && product.discount! > 20)
        .toList()
      ..sort((a, b) => b.discount!.compareTo(a.discount!));
  }

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void loadProducts() {
    isLoading.value = true;

    // Load hardcoded products
    products.assignAll([
      Product(
        id: "1",
        name: "Wireless Earbuds",
        description: "High-quality wireless earbuds with noise cancellation.",
        price: 49,
        imageUrl:
            "https://images.unsplash.com/photo-1572635196237-14b3f281503f",
        category: "Electronics",
        discount: 0,
        colors: [],
        storageOptions: [],
        isExclusiveDeal: true, // Marked as exclusive deal
        dealEndTime: DateTime.now().add(const Duration(hours: 24)),
      ),
      Product(
        id: "2",
        name: "Dumbbell Set",
        description: "Adjustable dumbbell set for home workouts.",
        price: 89999,
        imageUrl:
            "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa",
        category: "Fitness",
        discount: 15,
        colors: [],
        stock: 7,
        storageOptions: [],
        isExclusiveDeal: true, // Marked as exclusive deal
        dealEndTime: DateTime.now().add(const Duration(hours: 24)),
      ),
      Product(
        id: "3",
        name: "Leather Jacket",
        description: "Stylish leather jacket for all seasons.",
        price: 129,
        imageUrl:
            "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab",
        category: "Clothing",
        discount: 10,
        colors: [],
        stock: 5,
        storageOptions: [],
        isExclusiveDeal: true, // Marked as exclusive deal
        dealEndTime: DateTime.now().add(const Duration(hours: 24)),
      ),
      Product(
        id: "4",
        name: "Smart Watch",
        description: "Smart watch with fitness tracking and notifications.",
        price: 199,
        imageUrl: "https://images.unsplash.com/photo-1553062407-98eeb64c6a62",
        category: "Electronics",
        discount: 25,
        colors: [],
        storageOptions: [],
        isExclusiveDeal: true, // Marked as exclusive deal
        dealEndTime: DateTime.now().add(const Duration(hours: 24)),
      ),
      Product(
        id: "5",
        name: "Ceramic Mug",
        description: "Elegant ceramic mug for coffee or tea.",
        price: 9,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Home & Kitchen",
        discount: 0,
        colors: [],
        storageOptions: [],
        isExclusiveDeal: true, // Marked as exclusive deal
        dealEndTime: DateTime.now().add(const Duration(hours: 24)),
      ),
      Product(
        id: "6",
        name: "Running Shoes",
        description: "Comfortable running shoes for all terrains.",
        price: 59,
        imageUrl:
            "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa",
        category: "Footwear",
        discount: 30,
        colors: [],
        storageOptions: [],
        isExclusiveDeal: true, // Marked as exclusive deal
        dealEndTime: DateTime.now().add(const Duration(hours: 24)),
      ),
      Product(
        id: "7",
        name: "Backpack",
        description: "Durable backpack for travel and daily use.",
        price: 39,
        imageUrl: "https://images.unsplash.com/photo-1553062407-98eeb64c6a62",
        category: "Accessories",
        discount: 20,
        colors: [],
        storageOptions: [],
        isExclusiveDeal: true, // Marked as exclusive deal
        dealEndTime: DateTime.now().add(const Duration(hours: 24)),
      ),
      Product(
        id: "8",
        name: "Stainless Steel Kettle",
        description: "Electric stainless steel kettle with auto shut-off.",
        price: 29,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Home & Kitchen",
        discount: 15,
        colors: [],
        storageOptions: [],
        isExclusiveDeal: true, // Marked as exclusive deal
        dealEndTime: DateTime.now().add(const Duration(hours: 24)),
      ),
      Product(
        id: "9",
        name: "Yoga Mat",
        description: "Non-slip yoga mat for all fitness levels.",
        price: 19,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Fitness",
        discount: 10,
        colors: [],
        storageOptions: [],
        isExclusiveDeal: true, // Marked as exclusive deal
        dealEndTime: DateTime.now().add(const Duration(hours: 24)),
      ),
      Product(
        id: "10",
        name: "Sunglasses",
        description: "UV-protective sunglasses with a sleek design.",
        price: 24,
        imageUrl:
            "https://images.unsplash.com/photo-1572635196237-14b3f281503f",
        category: "Accessories",
        discount: 25,
        colors: [],
        storageOptions: [],
        isExclusiveDeal: true, // Marked as exclusive deal
        dealEndTime: DateTime.now().add(const Duration(hours: 24)),
      ),
      Product(
        id: "11",
        name: "Laptop Stand",
        description: "Ergonomic laptop stand for better posture.",
        price: 34,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Electronics",
        discount: 20,
        colors: [],
        storageOptions: [],
        isExclusiveDeal: true, // Marked as exclusive deal
        dealEndTime: DateTime.now().add(const Duration(hours: 24)),
      ),
      Product(
        id: "12",
        name: "Coffee Maker",
        description: "Automatic coffee maker for fresh brews.",
        price: 79,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Home & Kitchen",
        discount: 15,
        colors: [],
        storageOptions: [],
        isExclusiveDeal: true, // Marked as exclusive deal
        dealEndTime: DateTime.now().add(const Duration(hours: 24)),
      ),
      Product(
        id: "13",
        name: "T-Shirt",
        description: "Comfortable cotton T-shirt for casual wear.",
        price: 14,
        imageUrl:
            "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab",
        category: "Clothing",
        discount: 10,
        colors: [],
        storageOptions: [],
        isExclusiveDeal: true, // Marked as exclusive deal
        dealEndTime: DateTime.now().add(const Duration(hours: 24)),
      ),
      Product(
        id: "14",
        name: "Bluetooth Speaker",
        description: "Portable Bluetooth speaker with high-quality sound.",
        price: 44,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Electronics",
        discount: 25,
        colors: [],
        storageOptions: [],
        isExclusiveDeal: true, // Marked as exclusive deal
        dealEndTime: DateTime.now().add(const Duration(hours: 24)),
      ),
      Product(
        id: "15",
        name: "Desk Lamp",
        description: "Adjustable desk lamp with LED lighting.",
        price: 29,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Home & Kitchen",
        discount: 20,
        colors: [],
        storageOptions: [],
      ),
      Product(
        id: "16",
        name: "Sneakers",
        description: "Stylish sneakers for everyday wear.",
        price: 69,
        imageUrl:
            "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa",
        category: "Footwear",
        discount: 15,
        colors: [],
        storageOptions: [],
        isExclusiveDeal: true, // Marked as exclusive deal
        dealEndTime: DateTime.now().add(const Duration(hours: 24)),
      ),
      Product(
        id: "17",
        name: "Wallet",
        description: "Leather wallet with multiple compartments.",
        price: 19,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Accessories",
        discount: 10,
        colors: [],
        storageOptions: [],
        isExclusiveDeal: true, // Marked as exclusive deal
        dealEndTime: DateTime.now().add(const Duration(hours: 24)),
      ),
      Product(
        id: "18",
        name: "Exercise Bike",
        description: "Stationary exercise bike for home fitness.",
        price: 299,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Fitness",
        discount: 30,
        colors: [],
        storageOptions: [],
        isExclusiveDeal: true, // Marked as exclusive deal
        dealEndTime: DateTime.now().add(const Duration(hours: 24)),
      ),
      Product(
        id: "19",
        name: "Headphones",
        description: "Over-ear headphones with deep bass.",
        price: 59,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Electronics",
        discount: 20,
        colors: [],
        storageOptions: [],
      ),
      Product(
        id: "20",
        name: "Kitchen Knife Set",
        description: "Professional kitchen knife set with wooden block.",
        price: 49,
        imageUrl:
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
        category: "Home & Kitchen",
        discount: 15,
        colors: [],
        storageOptions: [],
      ),
    ]);

    // Update exclusive deals
    exclusiveDeals.assignAll(
      products
          .where((product) => product.discount != null && product.discount! > 0)
          .toList(),
    );

    // Update new arrivals (safely handle case where products.length < 5)
    newArrivals.assignAll(
      products.sublist(products.length > 5 ? products.length - 5 : 0),
    );

    // Update categories for "Shop by Category" and category chips
    categories.assignAll(
      products.map((product) => product.category).toSet().toList(),
    );

    // Initialize filtered products for search
    filteredProducts.assignAll(products);

    print('Products Loaded: ${products.length}');
    print('Exclusive Deals Loaded: ${exclusiveDeals.length}');
    print('New Arrivals Loaded: ${newArrivals.length}');
    print('Categories Loaded: ${categories.length}');

    isLoading.value = false;
  }

  // Search products (used in HomeScreen search bar)
  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      filteredProducts.assignAll(
        products
            .where(
              (product) =>
                  product.name.toLowerCase().contains(query.toLowerCase()) ||
                  product.category.toLowerCase().contains(query.toLowerCase()),
            )
            .toList(),
      );
    }
  }

  // Sort categories (for CategoriesScreen)
  void sortCategories(String order) {
    var sortedCategories = categories.toList();
    if (order == "A to Z") {
      sortedCategories.sort();
    } else if (order == "Z to A") {
      sortedCategories.sort((a, b) => b.compareTo(a));
    }
    categories.assignAll(sortedCategories);
  }

  // Sort exclusive deals (for ExclusiveDealsScreen)
  void sortDeals(String sortType) {
    var sortedDeals = exclusiveDeals.toList();
    if (sortType == "lowToHigh") {
      sortedDeals.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortType == "highToLow") {
      sortedDeals.sort((a, b) => b.price.compareTo(a.price));
    } else if (sortType == "discountHighToLow") {
      sortedDeals.sort((a, b) => b.discount!.compareTo(a.discount!));
    }
    exclusiveDeals.assignAll(sortedDeals);
  }

  // Filter exclusive deals by minimum discount (for ExclusiveDealsScreen)
  void filterDealsByDiscount(int minDiscount) {
    exclusiveDeals.assignAll(
      products
          .where((p) => p.discount != null && p.discount! >= minDiscount)
          .toList(),
    );
  }

  // Refresh products (for pull-to-refresh)
  void refreshProducts() {
    loadProducts();
  }
}
