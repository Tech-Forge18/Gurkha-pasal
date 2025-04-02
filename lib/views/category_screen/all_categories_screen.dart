import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/controllers/product_controller.dart';
import 'package:gurkha_pasal/views/product_screen/product_listing.dart';
import 'package:velocity_x/velocity_x.dart';

Widget ourButton({
  required VoidCallback onPress,
  required Color color,
  required Color textColor,
  required String title,
  Icon? icon,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 3,
      shadowColor: Colors.grey.withOpacity(0.3),
    ),
    onPressed: onPress,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[icon, 8.widthBox],
        title.text.color(textColor).fontFamily(bold).size(16).make(),
      ],
    ),
  );
}

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();
    final List<String> categories =
        productController.products
            .map((product) => product.category)
            .toSet()
            .toList();

    final Map<String, Map<String, dynamic>> categoryStyles = {
      "Electronics": {
        "color": Colors.blue.shade700,
        "icon": Icons.electrical_services,
        "gradient": const LinearGradient(
          colors: [Colors.blueAccent, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      },
      "Fitness": {
        "color": Colors.green.shade600,
        "icon": Icons.fitness_center,
        "gradient": const LinearGradient(
          colors: [Colors.greenAccent, Colors.green],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      },
      "Clothing": {
        "color": Colors.purple.shade600,
        "icon": Icons.checkroom,
        "gradient": const LinearGradient(
          colors: [Colors.purpleAccent, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      },
      "Footwear": {
        "color": Colors.orange.shade600,
        "icon": Icons.directions_run,
        "gradient": const LinearGradient(
          colors: [Colors.orangeAccent, Colors.orange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      },
      "Home & Kitchen": {
        "color": Colors.teal.shade600,
        "icon": Icons.kitchen,
        "gradient": const LinearGradient(
          colors: [Colors.tealAccent, Colors.teal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      },
      "Accessories": {
        "color": Colors.red.shade600,
        "icon": Icons.watch,
        "gradient": const LinearGradient(
          colors: [Colors.redAccent, Colors.red],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      },
    };

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title:
            "Categories".text
                .color(whiteColor)
                .fontFamily(bold)
                .size(22)
                .make(),
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: whiteColor),
            onPressed: () {
              Get.to(() => const SearchScreen()); // Navigate to SearchScreen
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: whiteColor),
            onPressed: () {
              _showFilterDialog(context); // Show filter dialog
            },
          ),
        ],
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        }
        if (categories.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.category_outlined, size: 80, color: fontGrey),
                16.heightBox,
                "No Categories Available".text
                    .fontFamily(semibold)
                    .size(18)
                    .color(darkFontGrey)
                    .make(),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.85, // Adjusted for better card proportions
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final style =
                categoryStyles[category] ??
                {
                  "color": primaryColor,
                  "icon": Icons.category,
                  "gradient": const LinearGradient(
                    colors: [Colors.grey, Colors.blueGrey],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                };
            return CategoryCard(
              category: category,
              color: style["color"] as Color,
              icon: style["icon"] as IconData,
              gradient: style["gradient"] as LinearGradient,
            );
          },
        );
      }),
      floatingActionButton: ourButton(
        onPress: () => Get.to(() => const ProductScreen(), arguments: null),
        color: primaryColor,
        textColor: whiteColor,
        title: 'All Products',
        icon: const Icon(Icons.list, color: whiteColor),
      ),
    );
  }

  // Filter dialog to sort categories
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              "Sort Categories".text
                  .fontFamily(bold)
                  .size(18)
                  .color(darkFontGrey)
                  .make(),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title:
                    "A to Z".text
                        .fontFamily(semibold)
                        .size(16)
                        .color(darkFontGrey)
                        .make(),
                onTap: () {
                  // Add sorting logic here
                  Get.snackbar("Sort", "Sorted A to Z");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title:
                    "Z to A".text
                        .fontFamily(semibold)
                        .size(16)
                        .color(darkFontGrey)
                        .make(),
                onTap: () {
                  // Add sorting logic here
                  Get.snackbar("Sort", "Sorted Z to A");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:
                  "Cancel".text
                      .fontFamily(semibold)
                      .size(16)
                      .color(primaryColor)
                      .make(),
            ),
          ],
        );
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;
  final Color color;
  final IconData icon;
  final LinearGradient gradient;

  const CategoryCard({
    super.key,
    required this.category,
    required this.color,
    required this.icon,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const ProductScreen(), arguments: category);
      },
      child: Container(
        // Removed AnimatedContainer for consistency (no animations)
        decoration: BoxDecoration(
          gradient: gradient,
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
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: whiteColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48,
                color: whiteColor,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
            ).pOnly(top: 16),
            12.heightBox,
            category.text
                .color(whiteColor)
                .fontFamily(bold)
                .size(16)
                .maxLines(2)
                .overflow(TextOverflow.ellipsis)
                .align(TextAlign.center)
                .make()
                .pSymmetric(h: 8, v: 4),
            8.heightBox,
            "Explore Now".text
                .color(whiteColor.withOpacity(0.8))
                .fontFamily(semibold)
                .size(12)
                .make(),
          ],
        ),
      ),
    );
  }
}

// Placeholder SearchScreen (to be implemented)
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Search".text.color(whiteColor).fontFamily(bold).size(22).make(),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: const Center(child: Text("Search functionality coming soon!")),
    );
  }
}
