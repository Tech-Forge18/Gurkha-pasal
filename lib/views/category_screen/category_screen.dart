import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/consts/images.dart';

import 'package:gurkha_pasal/views/category_screen/category_with_product.dart';
import 'package:gurkha_pasal/views/category_screen/custom_tabbar.dart';
import 'package:gurkha_pasal/views/category_screen/brandcards.dart';
import 'package:gurkha_pasal/views/category_screen/gird_layout.dart';
import 'package:gurkha_pasal/views/category_screen/product.dart';
// import 'package:gurkha_pasal/views/category_screen/product_card.dart'; // Ensure this import is correct

import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/Categories/cart.dart';


import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/appBar_widgets/homeappbar.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/appBar_widgets/searchContainer.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/circular_container.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/primary_header_container.dart';

import 'package:velocity_x/velocity_x.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // Separate data for BrandCards
  final List<Map<String, dynamic>> brandCardsData = const [
    {'title': 'Adidas', 'productCount': 18, 'imgPath': imgB1},
    {'title': 'Nike', 'productCount': 32, 'imgPath': imgB4},
    {'title': 'Puma', 'productCount': 10, 'imgPath': imgB5},
    {'title': 'Rolex', 'productCount': 5, 'imgPath': imgB9},
    {'title': 'Diamond', 'productCount': 8, 'imgPath': imgB1},
  ];

  // Separate data for CategoryWithProduct
  final Map<String, List<Product>> categoryProductsData = {
    'Shoes': [
     
    Product(
  id: '1',
  name: 'Adidas Sports Sneakers',
  description: 'High-performance Adidas sneakers perfect for any activity.',
  price: 85.99,
  imageUrl: imgP6,
  category: 'Shoes',
  originalPrice: 110.00,
  discount: 22, // 22% discount
),
Product(
  id: '2',
  name: 'Adidas Classic Shoes',
  description: 'Timeless Adidas design, offering comfort and style.',
  price: 79.99,
  imageUrl: imgSh1,
  category: 'Shoes',
  originalPrice: 100.00,
  discount: 20, // 20% discount
),
Product(
  id: '3',
  name: 'Nike Air Max',
  description: 'Nike Air Max with advanced cushioning and a sleek look.',
  price: 95.99,
  imageUrl: imgSh2,
  category: 'Shoes',
  originalPrice: 125.00,
  discount: 24, // 24% discount
),
Product(
  id: '4',
  name: 'Nike ZoomX Vaporfly',
  description: 'Ultimate racing shoes designed for speed and stability.',
  price: 104.99,
  imageUrl: imgSh3,
  category: 'Shoes',
  originalPrice: 140.00,
  discount: 25, // 25% discount
),
Product(
  id: '5',
  name: 'Nike Revolution 5',
  description: 'Nike Revolution 5 shoes offering lightweight cushioning.',
  price: 89.99,
  imageUrl: imgSh4,
  category: 'Shoes',
  originalPrice: 115.00,
  discount: 22, // 22% discount
),
Product(
  id: '6',
  name: 'Nike Pegasus Trail',
  description: 'Nike Pegasus shoes built for trail running with durable grip.',
  price: 102.99,
  imageUrl: imgSh5,
  category: 'Shoes',
  originalPrice: 135.00,
  discount: 24, // 24% discount
),

      
    ],
    'Clothes': [
      Product(
        id: '7',
        name: 'Nike T-Shirt',
        description: 'Breathable cotton t-shirt.',
        price: 29.99,
        imageUrl: imgFc1,
        category: 'Clothes',
        originalPrice: 45.00,
        discount: 33, // 33% discount
      ),
      Product(
        id: '8',
        name: 'Adidas Jacket',
        description: 'Warm and comfortable sports jacket.',
        price: 79.99,
        imageUrl: imgB5,
        category: 'Clothes',
        originalPrice: 100.00,
        discount: 20, // 20% discount
      ),
        Product(
        id: '9',
        name: 'Adidas Jacket',
        description: 'Warm and comfortable sports jacket.',
        price: 79.99,
        imageUrl: imgB5,
        category: 'Clothes',
        originalPrice: 100.00,
        discount: 20, // 20% discount
      ),
        Product(
        id: '10',
        name: 'Adidas Jacket',
        description: 'Warm and comfortable sports jacket.',
        price: 79.99,
        imageUrl: imgB5,
        category: 'Clothes',
        originalPrice: 100.00,
        discount: 20, // 20% discount
      ),
       Product(
        id: '11',
        name: 'Adidas Jacket',
        description: 'Warm and comfortable sports jacket.',
        price: 79.99,
        imageUrl: imgB5,
        category: 'Clothes',
        originalPrice: 100.00,
        discount: 20, // 20% discount
      ),
      
      

      

    ],
    // Add other categories here...
  };


  @override
  void initState() {
    super.initState();
    // Set the app to full-screen mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    // Restore the system UI when the screen is disposed
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: Container(
           
          color: whiteColor,
          child: NestedScrollView(
            headerSliverBuilder:
                (_, innerBoxIsScrolled) => [
                  SliverAppBar(
                    // backgroundColor: Colors.blue,
                    pinned: true,
                    floating: true,
                    expandedHeight: 468,
                    automaticallyImplyLeading: false,
                    backgroundColor: whiteColor,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.all(
                        0
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          PrimaryHeaderWidgets(
                            height: 420,
                       
                            child: Column(
                        children: [
                          const HomeAppBar( title: '  Welcome', title2: ' Product Category'),
                           SearchContainer(
                    text: 'Search products, brands...',
                    backgroundColor: whiteColor,
                    prefixIcon: Icon(Icons.search, color: primaryColor),
                  ),
                  10.heightBox,
                         
                   Padding(
                    padding: const EdgeInsets.all(10.0),
                     child: GirdLayout(
                              itemCount: brandCardsData.length,
                              mainAxisExtent: 70,
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: CircularContainer(
                                    radius: 10,
                                    child: BrandCards(
                                      showBorder: true,
                                      image: brandCardsData[index]['imgPath'],
                                      brandname: brandCardsData[index]['title'],
                                      productCount:
                                          brandCardsData[index]['productCount'],
                                    ),
                                  ),
                                );
                              },
                            ),
                   ),

                        ])),
                          
                         
                          
                         
                        ],
                      ),
                    ),
                    bottom: const CustomTabBar(
                      tabs: [
                        Tab(child: Text("Shoes")),
                        Tab(child: Text("Clothes")),
                        Tab(child: Text("Accessories")),
                        Tab(child: Text("Watches")),
                        Tab(child: Text("Jewellery")),
                      ],
                    ),
                  ),
                ],
            body: TabBarView(
              children: List.generate(5, (tabIndex) {
                final tabName =
                    categoryProductsData.keys.elementAtOrNull(tabIndex) ??
                    "Unknown";
                final currentTabData = categoryProductsData[tabName] ?? [];

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      if (currentTabData.isNotEmpty)
                        CategoryWithProduct(
                          showBorder: true,
                          image: currentTabData[0].imageUrl,
                          brandname: tabName,
                          productCount: currentTabData.length,
                          image1: currentTabData[0].imageUrl,
                          image2:
                              currentTabData.length > 1
                                  ? currentTabData[1].imageUrl
                                  : '',
                          image3:
                              currentTabData.length > 2
                                  ? currentTabData[2].imageUrl
                                  : '',
                        ),
                      const SizedBox(height: 20),

                      Expanded(
                        child:
                            currentTabData.isNotEmpty
                                ? GridView.builder(
                                  // itemCount: 10,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: 240,
                                        crossAxisSpacing: 12,
                                        mainAxisSpacing: 12,
                                        childAspectRatio: 0.7,
                                      ),
                                  itemCount: currentTabData.length,
                                  itemBuilder: (context, index) {
                                    final product = currentTabData[index];
                                    return ProductsScreen(
                                      img:product .imageUrl,
                                           
                                      name: product.name, // Pass the product name
                                         
                                      brand:
                                          product
                                              .category, // Pass the product category (brand)
                                      price:
                                          "\$${product.price}", // Format and pass the product price
                                      discount:
                                          "${product.discount}% OFF", // Format and pass the product discount
                                      // Ensure correct data is passed
                                    );
                                  },
                                )
                                : const Center(
                                  child: Text("No products available"),
                                ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
