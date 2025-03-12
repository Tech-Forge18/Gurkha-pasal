import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;

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
  }

  void clearCart() {
    cartItems.clear();
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

  double get total {
    return cartItems.fold(
      0,
      (sum, item) =>
          sum +
          (item['selected'] == true
              ? item['price'] * (item['quantity'] ?? 1)
              : 0),
    );
  }
}
