import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/controllers/product_controller.dart';
import 'package:gurkha_pasal/views/widgets_common/exclusive_product_card.dart';

class ExclusiveDealsScreen extends StatefulWidget {
  const ExclusiveDealsScreen({super.key});

  @override
  State<ExclusiveDealsScreen> createState() => _ExclusiveDealsScreenState();
}

class _ExclusiveDealsScreenState extends State<ExclusiveDealsScreen>
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
          'Exclusive Deals',
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
        if (productController.exclusiveDeals.isEmpty) {
          return const Center(child: Text('No exclusive deals available'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 160 / 220,
            ),
            itemCount: productController.exclusiveDeals.length,
            itemBuilder: (context, index) {
              final product = productController.exclusiveDeals[index];
              return AnimatedBuilder(
                animation: _gridAnimationController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _gridFadeAnimation.value,
                    child: ExclusiveDealCard(
                      product: product,
                      isCompact: false,
                      showStockInfo: true,
                      showOriginalPrice: true,
                      fromExclusiveDeals:
                          true, // Set to true for Exclusive Deals
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
