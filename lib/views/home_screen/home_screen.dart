import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/consts/images.dart';
import 'package:gurkha_pasal/controllers/product_controller.dart';
import 'package:gurkha_pasal/views/product_screen/product_details.dart';
import 'package:gurkha_pasal/views/product_screen/product_listing.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/Categories/hoem_categories.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/ViewAll/Section_hearding.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/appBar_widgets/searchContainer.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/appBar_widgets/homeappbar.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/primary_header_container.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            PrimaryHeaderWidgets(
              child: Column(
                children: [
                  const HomeAppBar(),
                  SearchContainer(
                    text: 'Search products, brands...',
                    backgroundColor: whiteColor,
                    prefixIcon: Icon(Icons.search, color: primaryColor),
                  ).p(16),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      children: [
                        SectionHeading(
                          title: 'Popular Categories',
                          showActionButton: true,
                          textColor: darkFontGrey,
                          onPressed: () {
                            /* Navigate to categories */
                          },
                        ),
                        const SizedBox(height: 14),
                        const HomeCategories(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Auto-playing Promo Slider
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.95,
                enlargeCenterPage: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
              ),
              items:
                  [imgS6, imgSs1, imgSs2, imgSs3, imgSs4]
                      .map(
                        (image) => ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      )
                      .toList(),
            ).p(16),

            // Interactive Ad Banner
            Container(
              height: 120,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_offer, color: whiteColor, size: 36),
                  16.widthBox,
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Exclusive Deals".text.white.bold.size(20).make(),
                        "Upto 70% OFF on selected items".text.white.semiBold
                            .size(14)
                            .make(),
                      ],
                    ),
                  ),
                ],
              ),
            ).onTap(() {
              // Add ad click action
            }),

            // Featured Products Section
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 24.0),
              child: SectionHeading(
                title: 'Featured Products',
                showActionButton: true,
                textColor: darkFontGrey,
                onPressed: () => Get.to(() => const ProductScreen()),
              ),
            ),

            // Product Grid
            Obx(
              () => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemCount:
                    productController.products.length > 4
                        ? 4
                        : productController.products.length,
                itemBuilder: (context, index) {
                  final product = productController.products[index];
                  return ProductCard(product: product);
                },
              ).p(16),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  product.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      color: lightGrey,
                      child: Center(
                        child: Icon(Icons.image, color: darkFontGrey),
                      ),
                    );
                  },
                ),
              ),
              if (product.discount != null && product.discount! > 0)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: redColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '-${product.discount}%\nOFF',
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: darkFontGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.price}',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (product.originalPrice != null)
                      Text(
                        '\$${product.originalPrice}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    /* Add to cart */
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    minimumSize: const Size(120, 40),
                  ),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(fontSize: 14),
                  ),
                ).pOnly(bottom: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
