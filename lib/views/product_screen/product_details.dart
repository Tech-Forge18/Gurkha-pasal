import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/controllers/cart_controller.dart';
import 'package:gurkha_pasal/models/product.dart';
import 'package:gurkha_pasal/views/cart_screen/cart.dart';
import 'package:gurkha_pasal/views/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: product.name.text.fontFamily(bold).white.make(),
        backgroundColor: redColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 300,
                    color: Colors.grey,
                    child: const Center(
                      child: Icon(Icons.error, color: whiteColor),
                    ),
                  );
                },
              ),
            ).p(16),

            // Product Name and Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  product.name.text
                      .color(whiteColor)
                      .fontFamily(bold)
                      .size(20)
                      .make(),
                  8.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "\$${product.price}".text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(18)
                          .make(),
                      if (product.originalPrice != null)
                        "\$${product.originalPrice}".text
                            .color(fontGrey)
                            .lineThrough
                            .size(16)
                            .make(),
                    ],
                  ),
                  if (product.discount != null && product.discount! > 0)
                    "${product.discount}% OFF".text
                        .color(greenColor)
                        .fontFamily(bold)
                        .size(16)
                        .make()
                        .pOnly(top: 8),
                  16.heightBox,

                  // Product Description
                  "Product Description".text
                      .color(whiteColor)
                      .fontFamily(semibold)
                      .size(16)
                      .make(),
                  8.heightBox,
                  product.description.text.color(darkFontGrey).size(14).make(),
                  24.heightBox,
                ],
              ),
            ),

            // Add to Cart and Buy Now Buttons
            Row(
              children: [
                Expanded(
                  child: ourButton(
                    color: redColor,
                    title: addToCart,
                    textColor: whiteColor,
                    onPress: () {
                      cartController.addToCart(product);
                      Get.snackbar(
                        "Success",
                        "${product.name} added to cart!",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: redColor,
                        colorText: whiteColor,
                      );
                    },
                  ),
                ),
                8.widthBox,
                Expanded(
                  child: ourButton(
                    color: lightGolden,
                    title: buyNow,
                    textColor: redColor,
                    onPress: () => Get.to(() => const CartScreen()),
                  ),
                ),
              ],
            ).p(16),
          ],
        ),
      ),
    );
  }
}
