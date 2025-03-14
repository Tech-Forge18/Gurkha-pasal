import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/consts/images.dart';
import 'package:gurkha_pasal/controllers/cart_controller.dart';
// New import for Profile screen
import 'package:gurkha_pasal/views/home_screen/home.dart';
import 'package:gurkha_pasal/views/widgets_common/cart_item.dart';
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
        252,
        249,
        249,
      ), // Updated to use bgColor from consts.dart
      appBar: AppBar(
        automaticallyImplyLeading: false, // We will manually add the back arrow
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                "My Cart".text
                    .fontFamily(bold)
                    .color(
                      const Color.fromARGB(255, 7, 7, 7),
                    ) // Updated to use darkFontGrey
                    .make(),
                8.widthBox,
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: primaryColor,
                  ), // Updated to use primaryColor
                  onPressed: () {
                    cartController.clearCart();
                  },
                ),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 36, 34, 34),
          ), // Back arrow
          onPressed: () {
            Get.off(() => const Home()); // Navigate to Home screen
          },
        ),
        backgroundColor: whiteColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Obx(() {
          if (cartController.cartItems.isEmpty) {
            return const EmptyCartView();
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartController.cartItems[index];
                    return CartItemCard(
                      item: item,
                      onRemove: () => cartController.removeFromCart(index),
                      onSelect:
                          (value) => cartController.selectItem(index, value),
                      onIncrease: () => cartController.increaseQuantity(index),
                      onDecrease: () => cartController.decreaseQuantity(index),
                    );
                  },
                ),
              ),
              CheckoutSection(total: cartController.total),
            ],
          );
        }),
      ),
    );
  }
}

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icCart,
          width: 80,
          color: primaryColor, // Updated to use primaryColor
        ),
        16.heightBox,
        "Your cart is empty".text
            .size(18)
            .color(
              const Color.fromARGB(255, 10, 5, 5),
            ) // Updated to use darkFontGrey
            .make(),
        16.heightBox,
        ourButton(
          color: orangeColor,
          title: "Continue Shopping",
          textColor: whiteColor,
          onPress: () => Get.offAll(() => const Home()),
        ).box.width(context.screenWidth * 0.8).make(),
      ],
    ).centered();
  }
}

class CheckoutSection extends StatelessWidget {
  final double total;

  const CheckoutSection({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  "Subtotal:".text
                      .fontFamily(semibold)
                      .color(darkFontGrey)
                      .make(),
                  4.widthBox,
                  "Rs. $total".text
                      .color(primaryColor) // Updated to use primaryColor
                      .fontFamily(bold)
                      .size(16)
                      .make(),
                ],
              ),
              "Rs. 0".text.color(greenColor).fontFamily(bold).size(14).make(),
            ],
          ),
          ourButton(
            color: orangeColor,
            title: "Check Out",
            textColor: whiteColor,
            onPress: () {
              Get.snackbar("Checkout", "Payment gateway integration pending");
            },
          ).box.width(120).make(),
        ],
      ),
    );
  }
}
