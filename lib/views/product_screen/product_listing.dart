import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/controllers/product_controller.dart';
import 'package:gurkha_pasal/views/product_screen/product_details.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductScreen extends StatelessWidget {
  final String? category;

  const ProductScreen({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 192, 190, 190),
      appBar: AppBar(
        title: "Product Listing".text.fontFamily(bold).white.make(),
        backgroundColor: redColor,
        elevation: 0,
      ),
      body: Obx(() {
        final filteredProducts =
            category == null || category!.isEmpty
                ? productController.products
                : productController.products
                    .where((product) => product.category == category)
                    .toList();
        return filteredProducts.isEmpty
            ? Center(
              child:
                  "No products found in this category".text
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .size(16)
                      .make(),
            )
            : GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => ProductDetailsScreen(product: product));
                  },
                  child: Card(
                    color: lightGrey,
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
                              child: Image.network(
                                product.imageUrl,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 120,
                                    color: Colors.grey,
                                    child: const Center(
                                      child: Icon(
                                        Icons.error,
                                        color: whiteColor,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            if (product.discount != null &&
                                product.discount! > 0)
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
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child:
                                      "${product.discount}% OFF".text
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
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              product.name.text
                                  .color(darkFontGrey)
                                  .fontFamily(semibold)
                                  .size(16)
                                  .make(),
                              4.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  "\$${product.price}".text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .size(16)
                                      .make(),
                                  if (product.originalPrice != null)
                                    "\$${product.originalPrice}".text
                                        .color(fontGrey)
                                        .lineThrough
                                        .size(14)
                                        .make(),
                                ],
                              ),
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
    );
  }
}
