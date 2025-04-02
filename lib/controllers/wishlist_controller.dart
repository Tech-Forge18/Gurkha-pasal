import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/models/product.dart';

class WishlistController extends GetxController {
  var wishlistItems = <Product>[].obs;

  void addToWishlist(Product product) {
    if (!wishlistItems.contains(product)) {
      wishlistItems.add(product);
      Get.snackbar(
        "Success",
        "${product.name} added to wishlist!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromRGBO(239, 104, 8, 1),
        colorText: const Color.fromRGBO(255, 255, 255, 1),
      );
    } else {
      Get.snackbar(
        "Info",
        "${product.name} is already in your wishlist!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromRGBO(200, 200, 200, 1),
        colorText: const Color.fromRGBO(255, 255, 255, 1),
      );
    }
  }

  void removeFromWishlist(Product product) {
    wishlistItems.remove(product);
    Get.snackbar(
      "Success",
      "${product.name} removed from wishlist!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color.fromRGBO(239, 104, 8, 1),
      colorText: const Color.fromRGBO(255, 255, 255, 1),
    );
  }
}
