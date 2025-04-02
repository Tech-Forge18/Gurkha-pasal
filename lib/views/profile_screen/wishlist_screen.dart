import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart' as consts;
import 'package:gurkha_pasal/controllers/wishlist_controller.dart';
import 'package:gurkha_pasal/views/product_screen/product_details.dart';
import 'package:velocity_x/velocity_x.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WishlistController wishlistController =
        Get.find<WishlistController>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title:
            "My Wishlist".text
                .fontFamily(consts.bold)
                .size(22)
                .color(consts.darkFontGrey)
                .make(),
        backgroundColor: consts.whiteColor,
        elevation: 3,
        shadowColor: Colors.grey.withOpacity(0.3),
      ),
      body: Obx(() {
        if (wishlistController.wishlistItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.favorite_border,
                  size: 80,
                  color: consts.fontGrey,
                ),
                16.heightBox,
                "Your wishlist is empty".text
                    .fontFamily(consts.semibold)
                    .size(18)
                    .color(consts.darkFontGrey)
                    .make(),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: wishlistController.wishlistItems.length,
          itemBuilder: (context, index) {
            final product = wishlistController.wishlistItems[index];
            return Card(
              color: consts.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 60,
                        height: 60,
                        color: consts.lightGrey,
                        child: const Icon(
                          Icons.image,
                          color: consts.darkFontGrey,
                        ),
                      );
                    },
                  ),
                ),
                title:
                    product.name.text
                        .fontFamily(consts.semibold)
                        .size(16)
                        .color(consts.darkFontGrey)
                        .make(),
                subtitle:
                    "Rs. ${product.price}".text
                        .fontFamily(consts.bold)
                        .size(14)
                        .color(consts.redColor)
                        .make(),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: consts.redColor),
                  onPressed: () {
                    wishlistController.removeFromWishlist(product);
                  },
                ),
                onTap: () {
                  Get.to(() => ProductDetailsScreen(product: product));
                },
              ),
            );
          },
        );
      }),
    );
  }
}
