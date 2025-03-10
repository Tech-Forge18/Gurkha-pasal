import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/consts/images.dart' show icCart;
import 'package:gurkha_pasal/controllers/cart_controller.dart';
import 'package:gurkha_pasal/views/home_screen/home.dart'; // Import Home screen for navigation
import 'package:gurkha_pasal/views/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        124,
        123,
        123,
      ), // Match your app's black background
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "My Cart".text.fontFamily(bold).white.make(),
            const SizedBox(width: 8),
            Image.asset(
              icCart, // Use your cart icon from consts/images.dart
              width: 24,
              color: whiteColor,
            ),
          ],
        ),
        backgroundColor: redColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(
        () =>
            cartController.cartItems.isEmpty
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        icCart, // Cart icon for empty state
                        width: 50,
                        color: whiteColor,
                      ),
                      "There are no items in this cart".text
                          .size(18)
                          .color(whiteColor)
                          .make()
                          .p(8),
                      ourButton(
                        color: orangeColor, // "Continue Shopping" button color
                        title: "Continue Shopping",
                        textColor: whiteColor,
                        onPress: () {
                          Get.off(
                            () => const Home(),
                          ); // Navigate to Home screen
                        },
                      ).box.width(context.screenWidth - 50).make().p(16),
                    ],
                  ),
                )
                : Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 0.75,
                            ),
                        itemCount: cartController.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartController.cartItems[index];
                          return Card(
                            color: lightGrey, // Light grey background for cards
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                      child:
                                          item["imageUrl"] != null
                                              ? Image.network(
                                                item["imageUrl"] as String,
                                                height: 120,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              )
                                              : const SizedBox(),
                                    ),
                                    if (item["discount"] != null &&
                                        (item["discount"] as num) > 0)
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: greenColor,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child:
                                              "${item["discount"]}% OFF".text
                                                  .color(whiteColor)
                                                  .size(12)
                                                  .fontFamily(bold)
                                                  .make(),
                                        ),
                                      ),
                                    const Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Icon(
                                        Icons.local_shipping,
                                        color: greenColor,
                                        size: 20,
                                      ), // Free delivery badge
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      (item["name"] as String).text
                                          .color(darkFontGrey)
                                          .fontFamily(semibold)
                                          .size(16)
                                          .make(),
                                      4.heightBox,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          "\$${item["price"]}".text
                                              .color(redColor)
                                              .fontFamily(bold)
                                              .size(16)
                                              .make(),
                                          if (item["originalPrice"] != null)
                                            "\$${item["originalPrice"]}".text
                                                .color(fontGrey)
                                                .lineThrough
                                                .size(14)
                                                .make(),
                                        ],
                                      ),
                                      4.heightBox,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          "Qty: ${item["quantity"]}".text
                                              .color(darkFontGrey)
                                              .make(),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: redColor,
                                            ),
                                            onPressed: () {
                                              cartController.removeFromCart(
                                                index,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      color: lightGrey,
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total: \$${cartController.total.toStringAsFixed(2)}"
                              .text
                              .size(18)
                              .fontFamily(bold)
                              .color(darkFontGrey)
                              .make(),
                          ourButton(
                            color: redColor,
                            title: "Checkout",
                            textColor: whiteColor,
                            onPress:
                                cartController.cartItems.isEmpty
                                    ? null
                                    : () {
                                      Get.snackbar(
                                        "Checkout",
                                        "Proceeding to checkout...",
                                      );
                                    },
                          ).box.width(120).make(),
                        ],
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
