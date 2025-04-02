import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart' as consts;
import 'package:gurkha_pasal/controllers/order_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.put(OrderController());

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title:
            "Order History".text
                .fontFamily(consts.bold)
                .size(22)
                .color(consts.darkFontGrey)
                .make(),
        backgroundColor: consts.whiteColor,
        elevation: 3,
        shadowColor: Colors.grey.withOpacity(0.3),
      ),
      body: Obx(() {
        if (orderController.orders.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_mall, size: 80, color: consts.fontGrey),
              16.heightBox,
              "You haven't placed any orders yet.".text
                  .fontFamily(consts.semibold)
                  .size(18)
                  .color(consts.darkFontGrey)
                  .make(),
              16.heightBox,
              "Start shopping now!".text
                  .fontFamily(consts.regular)
                  .size(14)
                  .color(consts.fontGrey)
                  .make(),
            ],
          ).centered();
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: orderController.orders.length,
          itemBuilder: (context, index) {
            final order = orderController.orders[index];
            return Card(
              color: consts.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Order #${order.id}".text
                            .fontFamily(consts.bold)
                            .size(16)
                            .color(consts.darkFontGrey)
                            .make(),
                        order.status.text
                            .fontFamily(consts.semibold)
                            .size(14)
                            .color(
                              order.status == "Delivered"
                                  ? consts.greenColor
                                  : consts.redColor,
                            )
                            .make(),
                      ],
                    ),
                    8.heightBox,
                    "Date: ${order.date}".text
                        .fontFamily(consts.regular)
                        .size(14)
                        .color(consts.fontGrey)
                        .make(),
                    4.heightBox,
                    "Total: Rs. ${order.total}".text
                        .fontFamily(consts.bold)
                        .size(14)
                        .color(consts.redColor)
                        .make(),
                    8.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.snackbar(
                              "Details",
                              "Order details feature coming soon!",
                            );
                          },
                          child:
                              "View Details".text
                                  .fontFamily(consts.semibold)
                                  .size(14)
                                  .color(consts.primaryColor)
                                  .make(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
