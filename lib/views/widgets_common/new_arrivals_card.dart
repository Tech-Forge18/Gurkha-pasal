// File: lib/views/widgets_common/new_arrival_product_card.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/models/product.dart';
import 'package:gurkha_pasal/views/product_screen/product_details.dart';
import 'package:velocity_x/velocity_x.dart';

class NewArrivalProductCard extends StatelessWidget {
  final Product product;

  const NewArrivalProductCard({Key? key, required this.product})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailsScreen(product: product));
      },
      child: Container(
        width: 140,
        height: 200, // Match TopTrendProductCard dimensions
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 255, 242, 232).withOpacity(0.9),
              const Color.fromARGB(255, 185, 183, 181),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                product.imageUrl,
                height: 180, // 90% of 200, matching TopTrendProductCard
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: Colors.grey,
                    child: const Center(
                      child: Icon(Icons.error, color: whiteColor),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 6,
                top: 1,
                right: 6,
                bottom: 1,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  product.name.text
                      .color(whiteColor)
                      .fontFamily(semibold)
                      .size(11)
                      .maxLines(1)
                      .overflow(TextOverflow.ellipsis)
                      .make(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "\$${product.price}".text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(11)
                          .make(),
                    ],
                  ),
                  if (product.discount != null && product.discount! > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child:
                          "${product.discount}% OFF".text
                              .color(whiteColor)
                              .fontFamily(bold)
                              .size(7)
                              .make(),
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
