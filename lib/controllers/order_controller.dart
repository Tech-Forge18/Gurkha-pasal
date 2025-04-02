import 'package:get/get.dart';
import 'package:gurkha_pasal/models/order.dart';

class OrderController extends GetxController {
  var orders = <Order>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Simulate fetching orders (replace with actual data fetching)
    orders.addAll([
      Order(id: "001", date: "Mar 02, 2025", total: 1500, status: "Delivered"),
      Order(id: "002", date: "Feb 28, 2025", total: 2500, status: "Shipped"),
      Order(id: "003", date: "Feb 15, 2025", total: 1800, status: "Delivered"),
    ]);
  }
}
