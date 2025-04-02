import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/models/product.dart';
import 'package:gurkha_pasal/views/product_screen/product_details.dart';
import 'package:velocity_x/velocity_x.dart';

class TopTrendProductCard extends StatelessWidget {
  final Product product;
  final bool isCompact;

  const TopTrendProductCard({
    super.key,
    required this.product,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailsScreen(product: product));
      },
      child: Container(
        width: 140,
        height: 200, // Increased height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 253, 240, 230).withOpacity(0.9),
              const Color.fromARGB(255, 199, 199, 198),
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
            // Image takes 60% of the card height
            Expanded(
              flex: 6,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  product.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey,
                      child: const Center(
                        child: Icon(Icons.error, color: whiteColor),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Text takes 40% of the card height
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    product.name.text
                        .color(const Color.fromARGB(255, 44, 43, 43))
                        .fontFamily(semibold)
                        .size(14)
                        .maxLines(1)
                        .overflow(TextOverflow.ellipsis)
                        .make(),
                    const SizedBox(height: 4),
                    "\RS.${product.price}".text
                        .color(redColor)
                        .fontFamily(bold)
                        .size(14)
                        .make(),
                    const SizedBox(height: 4),
                    if (product.discount != null && product.discount! > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: greenColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child:
                            "${product.discount}% OFF".text
                                .color(whiteColor)
                                .fontFamily(bold)
                                .size(10)
                                .make(),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
