import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/consts/list.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: categories.text.fontFamily(bold).white.make(),
        backgroundColor: redColor, // Consistent with your app’s color scheme
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: categoryList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final category = categoryList[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(
                  '/product_listing',
                  arguments: category,
                ); // Navigate to ProductListingScreen with category
              },
              child: Card(
                elevation: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: lightGrey,
                      child: category[0].text.size(24).color(fontGrey).make(),
                    ),
                    10.heightBox,
                    category.text
                        .fontFamily(semibold)
                        .size(16)
                        .color(const Color.fromARGB(255, 209, 131, 29))
                        .make(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
