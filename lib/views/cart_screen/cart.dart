import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/consts/images.dart';
import 'package:gurkha_pasal/controllers/cart_controller.dart';
import 'package:gurkha_pasal/views/home_screen/home.dart';
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "My Cart".text.fontFamily(bold).color(whiteColor).make(),
            const SizedBox(width: 8),
            Image.asset(icCart, width: 24, color: whiteColor),
          ],
        ),
        backgroundColor: redColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          if (cartController.cartItems.isEmpty) {
            return EmptyCartView();
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
              CheckoutSection(total: cartController.total.value),
            ],
          );
        }),
      ),
    );
  }
}

class EmptyCartView extends StatelessWidget {
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
    );
  }
}

class CartItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onRemove;
  final ValueChanged<bool> onSelect;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onSelect,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottomMargin: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: item["selected"] ?? false,
              onChanged: (value) => onSelect(value ?? false),
              activeColor: primaryColor,
            ),
            8.widthBox,
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item["imageUrl"] ?? "",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: lightGrey,
                        child: Center(
                          child: Icon(Icons.image, color: darkFontGrey),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.close, color: whiteColor),
                    onPressed: onRemove,
                  ),
                ),
              ],
            ),
            8.widthBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (item["name"] ?? "").text
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .make(),
                  4.heightBox,
                  Row(
                    children: [
                      if (item["originalPrice"] != null)
                        "\$${item["originalPrice"]}".text
                            .color(fontGrey)
                            .lineThrough
                            .make(),
                      8.widthBox,
                      "\$${item["price"]}".text
                          .color(primaryColor)
                          .fontFamily(bold)
                          .make(),
                    ],
                  ),
                  8.heightBox,
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: darkFontGrey),
                        onPressed: onDecrease,
                      ),
                      "${item["quantity"]}".text.make(),
                      IconButton(
                        icon: Icon(Icons.add, color: darkFontGrey),
                        onPressed: onIncrease,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
          "Enter Voucher Code".text.fontFamily(semibold).make(),
          8.heightBox,
          TextFormField(
            decoration: InputDecoration(
              hintText: "Voucher Code",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Total".text.fontFamily(semibold).make(),
              "\$$total".text
                  .color(primaryColor)
                  .fontFamily(bold)
                  .size(20)
                  .make(),
            ],
          ),
          ourButton(
            color: redColor,
            title: "Checkout",
            textColor: whiteColor,
            onPress: () {
              Get.snackbar("Checkout", "Payment gateway integration pending");
            },
          ).box.width(150).make(),
        ],
      ),
    );
  }
}
