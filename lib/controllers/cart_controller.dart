import 'package:get/get.dart';
import 'package:gurkha_pasal/models/product.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;
  var total = 0.0.obs;

  void addToCart(Product product) {
    int index = cartItems.indexWhere((item) => item["name"] == product.name);
    if (index != -1) {
      cartItems[index]["quantity"] = cartItems[index]["quantity"] + 1;
    } else {
      cartItems.add({
        "name": product.name,
        "price": product.price,
        "imageUrl": product.imageUrl,
        "quantity": 1,
        "discount": product.discount, // Now an int
        "originalPrice": product.originalPrice,
      });
    }
    _calculateTotal();
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
    _calculateTotal();
  }

  void _calculateTotal() {
    double sum = 0.0;
    for (var item in cartItems) {
      sum += (item["price"] as num) * (item["quantity"] as int);
    }
    total.value = sum;
  }
}
