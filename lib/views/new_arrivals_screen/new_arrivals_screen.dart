// File: lib/views/new_arrivals_screen/new_arrivals_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/controllers/product_controller.dart';
import 'package:gurkha_pasal/models/product.dart';
import 'package:gurkha_pasal/views/widgets_common/new_arrivals_card.dart';
import 'package:velocity_x/velocity_x.dart';

class NewArrivalsScreen extends StatefulWidget {
  const NewArrivalsScreen({Key? key}) : super(key: key);

  @override
  State<NewArrivalsScreen> createState() => _NewArrivalsScreenState();
}

class _NewArrivalsScreenState extends State<NewArrivalsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  String _selectedCategory = 'All';
  List<Product> _filteredProducts = [];
  late ProductController productController;

  @override
  void initState() {
    super.initState();
    // Initialize ProductController
    productController = Get.find<ProductController>();
    // Set initial filtered products to all products
    _filteredProducts = productController.products;

    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[100]!, Colors.grey[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Custom AppBar with Gradient and Shadow
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromRGBO(241, 111, 5, 1),
                    const Color.fromRGBO(255, 165, 0, 1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: whiteColor,
                            ),
                            onPressed: () => Get.back(),
                          ),
                          "New Arrivals".text
                              .color(whiteColor)
                              .size(20)
                              .fontFamily(bold)
                              .make(),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.sort, color: whiteColor),
                            onPressed: () {
                              Get.snackbar(
                                "Sort",
                                "Sorting functionality coming soon!",
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.favorite_border,
                              color: whiteColor,
                            ),
                            onPressed: () {
                              Get.snackbar(
                                "Wishlist",
                                "Wishlist functionality coming soon!",
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search new arrivals...',
                    prefixIcon: Icon(Icons.search, color: primaryColor),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _filteredProducts =
                          productController.products
                              .where(
                                (p) => p.name.toLowerCase().contains(
                                  value.toLowerCase(),
                                ),
                              )
                              .toList();
                    });
                  },
                ),
              ),
            ),
            // Category Chips with Padding Below
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryChip('All'),
                    _buildCategoryChip('Footwear'),
                    _buildCategoryChip('Accessories'),
                    _buildCategoryChip('Fitness'),
                    _buildCategoryChip('Electronics'),
                    _buildCategoryChip('Home & Kitchen'),
                    _buildCategoryChip('Clothing'),
                  ],
                ),
              ),
            ),
            // Add Space Between Category and Cards
            const SizedBox(height: 16),
            // Grid of Cards
            Expanded(
              child: Obx(
                () => GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio:
                        0.7, // Matches NewArrivalProductCard (140/200)
                  ),
                  itemCount: _filteredProducts.length,
                  itemBuilder: (context, index) {
                    return ScaleTransition(
                      scale: _animation,
                      child: NewArrivalProductCard(
                        product: _filteredProducts[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    bool isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
          if (category == 'All') {
            _filteredProducts = productController.products;
          } else {
            _filteredProducts =
                productController.products
                    .where((p) => p.category == category)
                    .toList();
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          category,
          style: TextStyle(
            color:
                isSelected ? whiteColor : const Color.fromARGB(255, 20, 20, 20),
            fontWeight: FontWeight.bold,
            fontSize: 14,
            fontFamily: semibold,
          ),
        ),
      ),
    );
  }
}
