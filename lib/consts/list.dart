// lib/consts/lists.dart

/// List of static product data for initial app testing.
/// Can be used as a fallback or seed data for ProductController.
const List<Map<String, dynamic>> productList = [
  {
    "id": "1",
    "name": "Smartphone",
    "price": 299.99,
    "image": "assets/images/smartphone.jpg",
    "category": "Electronics",
    "description": "Latest smartphone with advanced features.",
  },
  {
    "id": "2",
    "name": "T-Shirt",
    "price": 19.99,
    "image": "assets/images/tshirt.jpg",
    "category": "Fashion",
    "description": "Comfortable cotton t-shirt.",
  },
  {
    "id": "3",
    "name": "Sofa",
    "price": 499.99,
    "image": "assets/images/sofa.jpg",
    "category": "Home & Living",
    "description": "Modern sofa for your living room.",
  },
];

/// List of product categories for navigation and filtering.
const List<String> categoryList = [
  "Electronics",
  "Fashion",
  "Home & Living",
  "Beauty",
  "Sports",
  "Toys",
];

/// List of social media icon paths for LoginScreen.
const List<String> socialIconList = [
  "assets/icons/google.png",
  "assets/icons/facebook.png",
  "assets/icons/twitter.png",
];
