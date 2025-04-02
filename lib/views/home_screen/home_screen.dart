import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gurkha_pasal/views/TopTrendProductsScreen/TopTrendProductsScreen.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/consts/images.dart';
import 'package:gurkha_pasal/controllers/product_controller.dart';
import 'package:gurkha_pasal/models/product.dart';
import 'package:gurkha_pasal/views/cart_screen/cart.dart';
import 'package:gurkha_pasal/views/category_screen/all_categories_screen.dart';
import 'package:gurkha_pasal/views/exclusive_deal_screen/exclusive_deals_screen.dart';
import 'package:gurkha_pasal/views/product_screen/product_details.dart';
import 'package:gurkha_pasal/views/product_screen/product_listing.dart';
import 'package:gurkha_pasal/views/new_arrivals_screen/new_arrivals_screen.dart';
// Updated import
import 'package:gurkha_pasal/views/widgets_common/exclusive_product_card.dart';
import 'package:gurkha_pasal/views/widgets_common/homepageproduct.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/ViewAll/Section_hearding.dart';
import 'package:gurkha_pasal/views/widgets_common/top_trend_products.dart';
import 'package:velocity_x/velocity_x.dart';

Widget ourButton({
  required VoidCallback onPress,
  required Color color,
  required Color textColor,
  required String title,
  Icon? icon,
  bool isSmall = false,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding:
          isSmall
              ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
              : const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isSmall ? 6 : 8),
      ),
    ),
    onPressed: onPress,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[icon, 8.widthBox],
        title.text
            .color(textColor)
            .fontFamily(bold)
            .size(isSmall ? 12 : 16)
            .make(),
      ],
    ),
  );
}

Widget customSmallButton({
  required VoidCallback onPress,
  required String title,
  Color? gradientStartColor,
  Color? gradientEndColor,
}) {
  return GestureDetector(
    onTap: onPress,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      constraints: const BoxConstraints(maxWidth: 70),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            gradientStartColor ?? primaryColor,
            gradientEndColor ?? orangeColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(color: whiteColor, fontSize: 12, fontFamily: bold),
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  String _selectedCategory = 'All';
  List<Product> _filteredProducts = [];
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('HomeScreen: Initializing...');
    final controller = Get.find<ProductController>();
    _filteredProducts =
        controller.products
            .where((p) => p.discount != null && p.discount! > 0)
            .toList();
    print('HomeScreen: Filtered Products: ${_filteredProducts.length}');

    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildCategoryChip(String category) {
    bool isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
          final controller = Get.find<ProductController>();
          _filteredProducts =
              category == 'All'
                  ? controller.products
                      .where((p) => p.discount != null && p.discount! > 0)
                      .toList()
                  : controller.products
                      .where(
                        (p) =>
                            p.discount != null &&
                            p.discount! > 0 &&
                            p.category == category,
                      )
                      .toList();
          print(
            'HomeScreen: Category selected: $category, Filtered: ${_filteredProducts.length}',
          );
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          gradient:
              isSelected
                  ? LinearGradient(
                    colors: [primaryColor, orangeColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                  : null,
          color: isSelected ? null : Colors.transparent,
          border: Border.all(
            color:
                isSelected ? Colors.transparent : Colors.grey.withOpacity(0.5),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ]
                  : [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? whiteColor : darkFontGrey,
            fontWeight: FontWeight.w600,
            fontSize: 13,
            fontFamily: semibold,
          ),
        ),
      ),
    );
  }

  Widget _buildAdvertisementCard() {
    return GestureDetector(
      onTap: () {
        Get.to(() => const ProductScreen());
      },
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Colors.redAccent, Colors.orangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Hot Deal!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: bold,
                color: whiteColor,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            8.heightBox,
            Text(
              'Up to 50% Off',
              style: TextStyle(
                fontSize: 16,
                fontFamily: semibold,
                color: whiteColor,
              ),
              textAlign: TextAlign.center,
            ),
            8.heightBox,
            Text(
              'Shop Now!',
              style: TextStyle(
                fontSize: 14,
                fontFamily: regular,
                color: whiteColor.withOpacity(0.8),
                decoration: TextDecoration.underline,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBarContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            child: Transform.scale(
              scale: 1.5,
              child: Image.asset(
                'assets/icons/app_logo.png',
                height: 80,
                width: 80,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 60,
                    width: 60,
                    color: Colors.grey,
                    child: const Center(
                      child: Icon(Icons.error, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ),
          6.widthBox,
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color:
                      _isSearchFocused
                          ? orangeColor
                          : primaryColor.withOpacity(0.5),
                  width: 2.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        _isSearchFocused
                            ? orangeColor.withOpacity(0.4)
                            : primaryColor.withOpacity(0.2),
                    spreadRadius: _isSearchFocused ? 3 : 1,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                enabled: true,
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontFamily: semibold,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: _isSearchFocused ? orangeColor : primaryColor,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
                onSubmitted: (value) {
                  print('HomeScreen: Search query: $value');
                },
              ),
            ),
          ),
          15.widthBox,
          GestureDetector(
            onTap: () {
              Get.to(() => const CartScreen());
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              child: Icon(Icons.shopping_cart, color: primaryColor, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.5,
          viewportFraction: 0.99,
          enlargeCenterPage: false,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          padEnds: true,
        ),
        items:
            [imgS6, imgSs1, imgSs2, imgSs3, imgSs4].map((image) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        bottom: 12.0,
                        left: 12.0,
                        child: ourButton(
                          onPress: () {},
                          color: primaryColor,
                          textColor: whiteColor,
                          title: 'Shop Now',
                          isSmall: true,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildCategoryCard(String category) {
    final Map<String, Map<String, dynamic>> categoryStyles = {
      "Electronics": {
        "color": Colors.blue.shade700,
        "icon": Icons.electrical_services,
      },
      "Fitness": {"color": Colors.green.shade600, "icon": Icons.fitness_center},
      "Clothing": {"color": Colors.purple.shade600, "icon": Icons.checkroom},
      "Footwear": {
        "color": Colors.orange.shade600,
        "icon": Icons.directions_run,
      },
      "Home & Kitchen": {"color": Colors.teal.shade600, "icon": Icons.kitchen},
      "Accessories": {"color": Colors.red.shade600, "icon": Icons.watch},
    };

    final style =
        categoryStyles[category] ??
        {"color": primaryColor, "icon": Icons.category};

    return GestureDetector(
      onTap: () {
        Get.to(() => const ProductScreen(), arguments: category);
      },
      child: Container(
        width: 60,
        height: 80,
        decoration: BoxDecoration(
          color: style["color"] as Color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              style["icon"] as IconData,
              size: 24,
              color: whiteColor,
            ).pOnly(top: 6),
            category.text
                .color(whiteColor)
                .fontFamily(semibold)
                .size(8)
                .maxLines(2)
                .overflow(TextOverflow.ellipsis)
                .align(TextAlign.center)
                .make()
                .pSymmetric(h: 2, v: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildExclusiveDealCard(Product product) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ExclusiveDealCard(
        product: product,
        isCompact: true,
        showStockInfo: false,
        showOriginalPrice: true,
        hideOriginalPrice: true,
        discountFontSize: 7,
        fromExclusiveDeals: true, // Set to true for Exclusive Deals
        isHomeScreen: true,
      ),
    );
  }

  Widget _buildTopTrendCard(dynamic product) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => ProductDetailsScreen(
              product: product,
              fromExclusiveDeals: false, // Set to false for Top Trends
            ),
          );
        },
        child: TopTrendProductCard(product: product, isCompact: true),
      ),
    );
  }

  Widget _buildNewArrivalsCard() {
    final ProductController productController = Get.find<ProductController>();
    final newArrivals = productController.products.take(2).toList();

    return GestureDetector(
      onTap: () {
        Get.to(() => const NewArrivalsScreen());
      },
      child: Container(
        width: double.infinity,
        height: 320,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, orangeColor],
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'New Arrivals, New Excitement!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: bold,
                color: whiteColor,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (newArrivals.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => ProductDetailsScreen(
                          product: newArrivals[0],
                          fromExclusiveDeals:
                              false, // Set to false for New Arrivals
                        ),
                      );
                    },
                    child: Container(
                      width: 160,
                      height: 240,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: whiteColor.withOpacity(0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              newArrivals[0].imageUrl ?? '',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: const Color.fromARGB(
                                    255,
                                    253,
                                    237,
                                    237,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.image,
                                      color: const Color.fromARGB(
                                        255,
                                        252,
                                        227,
                                        227,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.2),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (newArrivals.length > 1)
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => ProductDetailsScreen(
                          product: newArrivals[1],
                          fromExclusiveDeals:
                              false, // Set to false for New Arrivals
                        ),
                      );
                    },
                    child: Container(
                      width: 178,
                      height: 263,
                      margin: const EdgeInsets.only(left: 9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: whiteColor.withOpacity(0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              newArrivals[1].imageUrl ?? '',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: lightGrey,
                                  child: Center(
                                    child: Icon(
                                      Icons.image,
                                      color: darkFontGrey,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.2),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();
    print('HomeScreen: Building...');
    print('HomeScreen: Products: ${productController.products.length}');

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (productController.products.isEmpty) {
          return const Center(child: Text('No products available'));
        }

        final categories =
            productController.products.map((p) => p.category).toSet().toList();

        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickySearchBarDelegateWithSafeArea(
                child: _buildSearchBarContainer(),
                minHeight: 72 + MediaQuery.of(context).padding.top,
                maxHeight: 72 + MediaQuery.of(context).padding.top,
              ),
            ),
            SliverToBoxAdapter(child: _buildSliderSection()),
            SliverToBoxAdapter(
              child: Container(
                height: 1,
                margin: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                color: Colors.grey[300],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SectionHeading(
                          title: 'Exclusive Deals',
                          showActionButton: false,
                          textColor: const Color.fromARGB(255, 20, 20, 20),
                          textStyle: TextStyle(
                            fontFamily: bold,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        customSmallButton(
                          onPress:
                              () => Get.to(() => const ExclusiveDealsScreen()),
                          title: 'Show More',
                          gradientStartColor: primaryColor,
                          gradientEndColor: orangeColor,
                        ).pOnly(right: 8),
                      ],
                    ),
                  ),
                  8.heightBox,
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          productController.exclusiveDeals.length > 4
                              ? 4
                              : productController.exclusiveDeals.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        return _buildExclusiveDealCard(
                          productController.exclusiveDeals[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 10,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(color: Colors.grey[300]),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SectionHeading(
                          title: 'Top Trend Products',
                          showActionButton: false,
                          textColor: const Color.fromARGB(255, 20, 20, 20),
                          textStyle: TextStyle(
                            fontFamily: bold,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        customSmallButton(
                          onPress:
                              () =>
                                  Get.to(() => const TopTrendProductsScreen()),
                          title: 'Show More',
                          gradientStartColor: primaryColor,
                          gradientEndColor: orangeColor,
                        ).pOnly(right: 8),
                      ],
                    ),
                  ),
                  8.heightBox,
                  SizedBox(
                    height: 228,
                    child: Obx(() {
                      final trendingProducts =
                          productController.products
                              .where(
                                (product) =>
                                    product.discount != null &&
                                    product.discount! > 0,
                              )
                              .toList()
                            ..sort(
                              (a, b) =>
                                  (b.discount ?? 0).compareTo(a.discount ?? 0),
                            );
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            trendingProducts.length > 4
                                ? 4
                                : trendingProducts.length,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemBuilder: (context, index) {
                          return _buildTopTrendCard(trendingProducts[index]);
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 10,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(color: Colors.grey[300]),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.only(left: 16, top: 16)),
                  _buildNewArrivalsCard(),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 10,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(color: Colors.grey[300]),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SectionHeading(
                          title: 'Shop by Category',
                          showActionButton: false,
                          textColor: const Color.fromARGB(255, 20, 20, 20),
                          textStyle: TextStyle(
                            fontFamily: bold,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.to(() => const CategoriesScreen()),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: primaryColor,
                            size: 24,
                          ),
                        ).pOnly(right: 16),
                      ],
                    ),
                  ),
                  8.heightBox,
                  SizedBox(
                    height: 75,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length > 6 ? 6 : categories.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: _buildCategoryCard(categories[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(color: Colors.grey[300]),
              ),
            ),
            SliverAppBar(
              pinned: true,
              floating: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 40,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [whiteColor, Colors.grey.shade100],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      top: 0.0,
                      bottom: 6.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeading(
                          title: '',
                          showActionButton: true,
                          textColor: const Color.fromARGB(255, 15, 15, 15),
                          textStyle: const TextStyle(
                            fontFamily: bold,
                            fontSize: 16,
                          ),
                          onPressed: () => Get.to(() => const ProductScreen()),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -15.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _buildCategoryChip('All'),
                                _buildCategoryChip('Best Sale'),
                                _buildCategoryChip('Health & Beauty'),
                                _buildCategoryChip('Electronics'),
                                _buildCategoryChip('Accessories'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  childAspectRatio: 0.7,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index == 1) {
                    return _buildAdvertisementCard();
                  }
                  int productIndex = index > 1 ? index - 1 : index;
                  if (productIndex >= _filteredProducts.length) {
                    return const SizedBox.shrink();
                  }
                  final product = _filteredProducts[productIndex];
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => ProductDetailsScreen(
                          product: product,
                          fromExclusiveDeals:
                              false, // Set to false for filtered products
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ProductCard(product: product),
                    ),
                  );
                }, childCount: _filteredProducts.length + 1),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _StickySearchBarDelegateWithSafeArea
    extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minHeight;
  final double maxHeight;

  _StickySearchBarDelegateWithSafeArea({
    required this.child,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) => Container(
    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    color: whiteColor,
    child: child,
  );

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
