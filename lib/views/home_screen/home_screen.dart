// HomeScreen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/consts/images.dart';
import 'package:gurkha_pasal/controllers/product_controller.dart';
import 'package:gurkha_pasal/views/exclusive_deal_screen/exclusive_deals_screen.dart';
import 'package:gurkha_pasal/views/product_screen/product_listing.dart';
import 'package:gurkha_pasal/views/widgets_common/exclusive_product_card.dart';
import 'package:gurkha_pasal/views/widgets_common/featured_product.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/Categories/hoem_categories.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/ViewAll/Section_hearding.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/appBar_widgets/searchContainer.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/appBar_widgets/homeappbar.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/primary_header_container.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Show the popup when the screen is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPromoPopup();
    });
  }

  void _showPromoPopup() {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Container(
          width: double.maxFinite,
          height: 400,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 120, 255, 1), // Blue gradient start
                Color.fromRGBO(255, 165, 0, 1), // Orange gradient end
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Stack(
            children: [
              // Background Image or Placeholder
              Center(
                child: Image.asset(
                  imgSs1, // Placeholder image; replace with a promotional image
                  fit: BoxFit.contain,
                  height: 300,
                ),
              ),
              // Text Overlays
              Positioned(
                top: 16,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "GURKHA PASAL",
                      style: TextStyle(
                        fontFamily: bold,
                        fontSize: 20,
                        color: whiteColor,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: const Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Presents Gurkha Mela",
                      style: TextStyle(
                        fontFamily: semibold,
                        fontSize: 16,
                        color: whiteColor,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: const Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 90,
                left: 16,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: orangeColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "UP TO 60% OFF",
                        style: TextStyle(
                          fontFamily: bold,
                          fontSize: 16,
                          color: whiteColor,
                        ),
                      ),
                    ),
                    8.widthBox,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: orangeColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "NEW ARRIVALS",
                        style: TextStyle(
                          fontFamily: bold,
                          fontSize: 16,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Close Button
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.close, color: whiteColor),
                  onPressed: () => Get.back(),
                ),
              ),
              // Add to Cart Button
            ],
          ),
        ),
      ),
      barrierDismissible: true, // Allow tapping outside to dismiss
    );
  }

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
              height: 370,
              child: Column(
                children: [
                  const HomeAppBar(title: 'Good Morning', title2: 'Ishowr'),
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
                          textColor: const Color.fromARGB(255, 20, 20, 20),
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

            // Exclusive Deals Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SectionHeading(
                        title: 'Exclusive Deals',
                        showActionButton: false,
                        textColor: const Color.fromARGB(255, 20, 20, 20),
                        textStyle: TextStyle(
                          fontFamily: bold,
                          fontSize: 16,
                          color: Color.fromARGB(255, 20, 20, 20),
                        ),
                      ),
                      TextButton(
                        onPressed:
                            () => Get.to(() => const ExclusiveDealsScreen()),
                        child: Text(
                          'Show More',
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 220,
                  child: Obx(
                    () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          productController.exclusiveDeals.length > 4
                              ? 4
                              : productController.exclusiveDeals.length,
                      padding: const EdgeInsets.only(left: 16),
                      itemBuilder: (context, index) {
                        return ExclusiveDealCard(
                          product: productController.exclusiveDeals[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            // Featured Products Section
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 24.0),
              child: SectionHeading(
                title: 'Featured Products',
                showActionButton: true,
                textColor: const Color.fromARGB(255, 19, 18, 18),
                textStyle: TextStyle(
                  fontFamily: bold,
                  fontSize: 16,
                  color: Color.fromARGB(255, 20, 20, 20),
                ),
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
                  childAspectRatio: 0.65,
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
