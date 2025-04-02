import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/consts/images.dart';
import 'package:gurkha_pasal/controllers/cart_controller.dart';
import 'package:gurkha_pasal/controllers/product_controller.dart';
import 'package:gurkha_pasal/views/home_screen/home.dart';
import 'package:gurkha_pasal/views/product_screen/product_details.dart';
import 'package:gurkha_pasal/views/widgets_common/our_button.dart';
import 'package:gurkha_pasal/views/widgets_common/homepageproduct.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    final ProductController productController = Get.find<ProductController>();
    final TextEditingController couponController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: cartController.cartItems.every(
                      (item) => item['selected'] == true,
                    ),
                    onChanged: (value) {
                      for (
                        int i = 0;
                        i < cartController.cartItems.length;
                        i++
                      ) {
                        cartController.selectItem(i, value ?? false);
                      }
                    },
                    activeColor: redColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                "My Cart".text
                    .fontFamily(bold)
                    .size(22)
                    .color(darkFontGrey)
                    .make(),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: redColor, size: 28),
                  onPressed: () {
                    bool hasSelectedItems = cartController.cartItems.any(
                      (item) => item["selected"] == true,
                    );
                    if (hasSelectedItems) {
                      Get.defaultDialog(
                        title: "Delete Selected Items",
                        middleText:
                            "Are you sure you want to delete the selected items?",
                        textConfirm: "Yes",
                        textCancel: "No",
                        confirmTextColor: whiteColor,
                        onConfirm: () {
                          cartController.deleteSelectedItems();
                          Get.back();
                          Get.snackbar(
                            "Success",
                            "Selected items removed from cart!",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: redColor,
                            colorText: whiteColor,
                          );
                        },
                        onCancel: () {},
                      );
                    } else {
                      Get.snackbar(
                        "No Selection",
                        "Please select items to delete.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: darkFontGrey,
                        colorText: whiteColor,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkFontGrey, size: 28),
          onPressed: () {
            Get.off(() => const Home());
          },
        ),
        backgroundColor: whiteColor,
        elevation: 3,
        shadowColor: Colors.grey.withOpacity(0.3),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cart Items Section
                    Obx(() {
                      if (cartController.cartItems.isEmpty) {
                        return Column(
                          children: [
                            40.heightBox,
                            Image.asset(
                              icCart,
                              width: 100,
                              color: primaryColor.withOpacity(0.7),
                            ),
                            16.heightBox,
                            "Your cart is empty".text
                                .size(22)
                                .fontFamily(semibold)
                                .color(darkFontGrey.withOpacity(0.8))
                                .make(),
                            16.heightBox,
                            ourButton(
                              color: orangeColor,
                              title: "Continue Shopping",
                              textColor: whiteColor,
                              onPress: () => Get.offAll(() => const Home()),
                            ).box.width(context.screenWidth * 0.6).make(),
                            24.heightBox,
                          ],
                        ).centered();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                "Cart Items (${cartController.cartItems.length})"
                                    .text
                                    .size(18)
                                    .fontFamily(bold)
                                    .color(darkFontGrey)
                                    .make(),
                              ],
                            ),
                          ),
                          Divider(color: Colors.grey[300], thickness: 1),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(16),
                            itemCount: cartController.cartItems.length,
                            itemBuilder: (context, index) {
                              final item = cartController.cartItems[index];
                              return CartItemCard(
                                item: item,
                                onRemove:
                                    () => cartController.removeFromCart(index),
                                onSelect:
                                    (value) =>
                                        cartController.selectItem(index, value),
                                onIncrease:
                                    () =>
                                        cartController.increaseQuantity(index),
                                onDecrease:
                                    () =>
                                        cartController.decreaseQuantity(index),
                              );
                            },
                          ),
                        ],
                      );
                    }),
                    // Explore Products Section
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      color: whiteColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Explore Products".text
                              .size(18)
                              .fontFamily(bold)
                              .color(darkFontGrey)
                              .make(),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const Home());
                            },
                            child:
                                "See More".text
                                    .size(14)
                                    .fontFamily(semibold)
                                    .color(primaryColor)
                                    .make(),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey[300], thickness: 1),
                    Obx(() {
                      if (productController.products.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: const Center(
                            child: Text('No products available'),
                          ),
                        );
                      }
                      final suggestedProducts =
                          productController.products.toList();
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.75,
                            ),
                        itemCount:
                            suggestedProducts.length > 10
                                ? 10
                                : suggestedProducts.length,
                        itemBuilder: (context, index) {
                          final product = suggestedProducts[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => ProductDetailsScreen(product: product),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 6,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                    child: Image.network(
                                      product.imageUrl,
                                      height: 120,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return Container(
                                          height: 120,
                                          color: lightGrey,
                                          child: const Center(
                                            child: Icon(
                                              Icons.image,
                                              color: darkFontGrey,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        product.name.text
                                            .size(14)
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .maxLines(1)
                                            .overflow(TextOverflow.ellipsis)
                                            .make(),
                                        4.heightBox,
                                        "Rs. ${product.price}".text
                                            .size(14)
                                            .fontFamily(bold)
                                            .color(redColor)
                                            .make(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                    24.heightBox,
                  ],
                ),
              ),
            ),
            // Coupon Code Section (Only visible when cart is not empty)
            Obx(() {
              if (cartController.cartItems.isEmpty) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: couponController,
                        decoration: InputDecoration(
                          hintText: "Enter Coupon Code",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 124, 122, 122),
                            ),
                          ),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 201, 198, 198),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    8.widthBox,
                    ourButton(
                      color: primaryColor,
                      title: "Apply",
                      textColor: whiteColor,
                      onPress: () {
                        if (couponController.text.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please enter a coupon code.",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: redColor,
                            colorText: whiteColor,
                          );
                        } else {
                          // Simulate coupon application logic
                          cartController.applyCoupon(couponController.text);
                          couponController.clear();
                        }
                      },
                    ).box.width(80).height(50).make(),
                  ],
                ),
              );
            }),
            // Checkout Section
            Obx(() {
              if (cartController.cartItems.isEmpty) {
                return const SizedBox.shrink();
              }
              return CheckoutSection(total: cartController.total);
            }),
          ],
        ),
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
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 112, 111, 110).withOpacity(0.2),
            whiteColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      "Subtotal:".text
                          .fontFamily(semibold)
                          .color(const Color.fromARGB(255, 32, 31, 31))
                          .size(16)
                          .make(),
                      4.widthBox,
                      "Rs. $total".text
                          .color(primaryColor)
                          .fontFamily(bold)
                          .size(18)
                          .make(),
                    ],
                  ),
                  4.heightBox,
                  "Free Shipping".text
                      .color(greenColor)
                      .fontFamily(semibold)
                      .size(14)
                      .make(),
                ],
              ),
              ourButton(
                color: orangeColor,
                title: "Check Out",
                textColor: whiteColor,
                onPress: () {
                  Get.snackbar(
                    "Checkout",
                    "Payment gateway integration pending",
                  );
                },
              ).box.width(140).height(50).make(),
            ],
          ),
          8.heightBox,
          "Est. Delivery: ${DateTime.now().add(const Duration(days: 5)).toString().split(' ')[0]}"
              .text
              .color(const Color.fromARGB(255, 3, 3, 3))
              .fontFamily(semibold)
              .size(14)
              .make(),
        ],
      ),
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
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: item["selected"] ?? false,
              onChanged: (value) => onSelect(value ?? false),
              activeColor: redColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            8.widthBox,
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
                    child: const Center(
                      child: Icon(Icons.image, color: darkFontGrey),
                    ),
                  );
                },
              ),
            ),
            12.widthBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["name"] ?? "",
                    style: const TextStyle(
                      color: darkFontGrey,
                      fontFamily: semibold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  4.heightBox,
                  if (item["selectedColor"] != null)
                    Text(
                      "Color: ${item["selectedColor"]}",
                      style: const TextStyle(color: fontGrey, fontSize: 12),
                    ),
                  8.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (item["originalPrice"] != null)
                            Text(
                              "Rs. ${item["originalPrice"]}",
                              style: const TextStyle(
                                color: fontGrey,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12,
                              ),
                            ),
                          8.widthBox,
                          Text(
                            "Rs. ${item["price"]}",
                            style: const TextStyle(
                              color: redColor,
                              fontFamily: bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.remove,
                                color: darkFontGrey,
                                size: 20,
                              ),
                              onPressed: onDecrease,
                            ),
                            Text(
                              "${item["quantity"]}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: darkFontGrey,
                                fontFamily: bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.add,
                                color: darkFontGrey,
                                size: 20,
                              ),
                              onPressed: onIncrease,
                            ),
                          ],
                        ),
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
