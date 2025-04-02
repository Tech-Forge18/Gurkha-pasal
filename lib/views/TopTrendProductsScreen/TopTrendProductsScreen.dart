import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/controllers/product_controller.dart';
import 'package:gurkha_pasal/models/product.dart';
import 'package:gurkha_pasal/views/widgets_common/top_trend_products.dart';

class TopTrendProductsScreen extends StatefulWidget {
  const TopTrendProductsScreen({super.key});

  @override
  State<TopTrendProductsScreen> createState() => _TopTrendProductsScreenState();
}

class _TopTrendProductsScreenState extends State<TopTrendProductsScreen>
    with TickerProviderStateMixin {
  late AnimationController _gridAnimationController;
  late Animation<double> _gridFadeAnimation;

  @override
  void initState() {
    super.initState();
    _gridAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _gridFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _gridAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    _gridAnimationController.forward();
  }

  @override
  void dispose() {
    _gridAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Top Trend Products',
          style: TextStyle(
            fontFamily: 'bold',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (productController.products.isEmpty) {
          return const Center(child: Text('No top trend products available'));
        }

        final trendingProducts =
            productController.products
                .where(
                  (product) =>
                      product.discount != null && product.discount! > 0,
                )
                .toList()
              ..sort((a, b) => (b.discount ?? 0).compareTo(a.discount ?? 0));

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 columns
              mainAxisSpacing: 12, // Vertical spacing between cards
              crossAxisSpacing: 12, // Horizontal spacing between cards
              childAspectRatio: 0.75, // Adjusted for better layout
            ),
            itemCount: trendingProducts.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _gridAnimationController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _gridFadeAnimation.value,
                    child: TopTrendProductCard(
                      product: trendingProducts[index],
                      isCompact: false, // Full version for this screen
                    ),
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }
}
