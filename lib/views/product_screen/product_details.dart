import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/controllers/cart_controller.dart';
import 'package:gurkha_pasal/models/product.dart';
import 'package:gurkha_pasal/views/cart_screen/cart.dart';
import 'package:gurkha_pasal/views/review_screen/user_review.dart';
import 'package:gurkha_pasal/views/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 244, 244),
      appBar: AppBar(
        title: product.name.text.fontFamily(bold).white.make(),
        backgroundColor: redColor,
      ),
      body: Column(
        children: [
          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
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
                          color: const Color.fromARGB(255, 43, 42, 42),
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
                            .color(const Color.fromARGB(255, 5, 5, 5))
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
                            .color(const Color.fromARGB(255, 12, 12, 12))
                            .fontFamily(semibold)
                            .size(16)
                            .make(),
                        8.heightBox,
                        product.description.text
                            .color(const Color.fromARGB(255, 68, 65, 65))
                            .size(14)
                            .make(),
                        24.heightBox,

                        // Animated GurkhaPasal Benefits Section
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              FadeAnimatedText(
                                'GurkhaPasal Benefits',
                                textStyle: TextStyle(
                                  color: const Color.fromARGB(255, 8, 8, 8),
                                  fontFamily: semibold,
                                  fontSize: 16,
                                ),
                                duration: const Duration(milliseconds: 1500),
                              ),
                            ],
                            repeatForever: true,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 112, 108, 108),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildBenefitRow(
                                Icons.verified_user,
                                "100% Authentic",
                              ),
                              8.heightBox,
                              _buildBenefitRow(
                                Icons.verified,
                                "GurkhaVerified",
                              ),
                              8.heightBox,
                              _buildBenefitRow(
                                Icons.refresh,
                                "15 Days Easy Return",
                              ),
                            ],
                          ),
                        ).pOnly(bottom: 24),

                        // Reviews Section with Navigation
                        GestureDetector(
                          onTap: () => Get.to(() => const ReviewScreen()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Reviews".text
                                  .color(const Color.fromARGB(255, 8, 8, 8))
                                  .fontFamily(semibold)
                                  .size(16)
                                  .make(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: const Color.fromARGB(255, 14, 13, 13),
                                size: 16,
                              ),
                            ],
                          ).pOnly(bottom: 8),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  231,
                                  138,
                                  25,
                                ),
                                child: Text(
                                  "U",
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      49,
                                      47,
                                      47,
                                    ),
                                  ),
                                ),
                              ),
                              title:
                                  "User $index".text
                                      .color(
                                        const Color.fromARGB(255, 20, 20, 20),
                                      )
                                      .make(),
                              subtitle:
                                  "Great product quality!".text
                                      .color(
                                        const Color.fromARGB(255, 53, 51, 51),
                                      )
                                      .make(),
                            );
                          },
                        ),
                        16.heightBox,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Fixed Footer with Buttons
          Container(
            color: whiteColor,
            padding: const EdgeInsets.all(16),
            child: Row(
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
                    icon: const Icon(Icons.shopping_cart, color: whiteColor),
                  ),
                ),
                8.widthBox,
                Expanded(
                  child: ourButton(
                    color: lightGolden,
                    title: buyNow,
                    textColor: redColor,
                    onPress: () => Get.to(() => const CartScreen()),
                    icon: const Icon(Icons.payment, color: redColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Benefit Row Builder
  Widget _buildBenefitRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 18),
        8.widthBox,
        text.text.color(darkFontGrey).size(14).make(),
      ],
    );
  }
}
