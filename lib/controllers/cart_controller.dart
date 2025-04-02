import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart'
    as consts; // Use 'as' prefix to avoid ambiguity

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;
  var discount = 0.0.obs; // To store the applied discount

  void addToCart(Map<String, dynamic> product) {
    int index = cartItems.indexWhere(
      (item) =>
          item['id'] == product['id'] &&
          item['selectedColor'] == product['selectedColor'],
    );

    if (index != -1) {
      cartItems[index]['quantity'] += product['quantity'];
    } else {
      cartItems.add({
        ...product,
        'selected': true, // Default to selected
      });
    }
    cartItems.refresh();
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
    cartItems.refresh();
  }

  void clearCart() {
    cartItems.clear();
    cartItems.refresh();
  }

  void selectItem(int index, bool value) {
    cartItems[index]['selected'] = value;
    cartItems.refresh();
  }

  void increaseQuantity(int index) {
    cartItems[index]['quantity'] = (cartItems[index]['quantity'] ?? 1) + 1;
    cartItems.refresh();
  }

  void decreaseQuantity(int index) {
    if (cartItems[index]['quantity'] > 1) {
      cartItems[index]['quantity'] -= 1;
    } else {
      cartItems.removeAt(index);
    }
    cartItems.refresh();
  }

  void deleteSelectedItems() {
    cartItems.removeWhere((item) => item['selected'] == true);
    cartItems.refresh();
  }

  void applyCoupon(String couponCode) {
    // Simulate coupon logic (you can replace this with actual logic)
    if (couponCode.toUpperCase() == "SAVE10") {
      double subtotal = cartItems.fold(
        0,
        (sum, item) =>
            sum +
            (item['selected'] == true
                ? (item['price'] as num) * (item['quantity'] as num)
                : 0),
      );
      discount.value = subtotal * 0.1; // 10% discount
      Get.snackbar(
        "Success",
        "Coupon applied! You saved Rs. ${discount.value.toStringAsFixed(2)}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: consts.greenColor,
        colorText: consts.whiteColor,
      );
    } else {
      discount.value = 0.0;
      Get.snackbar(
        "Error",
        "Invalid coupon code.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: consts.redColor,
        colorText: consts.whiteColor,
      );
    }
  }

  double get total {
    double subtotal = cartItems.fold(
      0,
      (sum, item) =>
          sum +
          (item['selected'] == true
              ? (item['price'] as num) * (item['quantity'] as num)
              : 0),
    );
    return subtotal - discount.value; // Subtract the discount from the subtotal
  }
}
