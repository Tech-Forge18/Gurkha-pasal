import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/consts/images.dart';
import 'package:gurkha_pasal/controllers/cart_controller.dart';
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
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                "My Cart".text.fontFamily(bold).color(darkFontGrey).make(),
                8.widthBox,
                const Icon(Icons.location_on, color: redColor, size: 18),
                4.widthBox,
                "Shankhamul Area, Kathmandu Me...".text
                    .color(fontGrey)
                    .size(12)
                    .make(),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: redColor),
              onPressed: () {
                cartController.clearCart();
              },
            ),
          ],
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
              VoucherCodeSection(),
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
        Image.asset(icCart, width: 80, color: whiteColor),
        16.heightBox,
        "Your cart is empty".text.size(18).color(whiteColor).make(),
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

class VoucherCodeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.local_offer, color: redColor, size: 18),
                  8.widthBox,
                  "Vouchers".text
                      .fontFamily(semibold)
                      .color(darkFontGrey)
                      .make(),
                ],
              ),
              DropdownButton<String>(
                value: "ALL",
                items: [
                  const DropdownMenuItem(value: "ALL", child: Text("ALL")),
                  const DropdownMenuItem(
                    value: "DISCOUNT",
                    child: Text("DISCOUNT"),
                  ),
                  const DropdownMenuItem(
                    value: "FREESHIP",
                    child: Text("FREESHIP"),
                  ),
                ],
                onChanged: (value) {},
                underline: const SizedBox(),
                icon: const Icon(Icons.arrow_drop_down, color: darkFontGrey),
              ),
            ],
          ),
          8.heightBox,
          TextFormField(
            decoration: InputDecoration(
              hintText: "Enter Voucher Code",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: lightGrey),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
          ),
        ],
      ),
    );
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
                      .color(redColor)
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
