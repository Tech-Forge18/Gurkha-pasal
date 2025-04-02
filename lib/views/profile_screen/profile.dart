import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart' as consts;
import 'package:gurkha_pasal/controllers/followed_stores_controller.dart';
import 'package:gurkha_pasal/controllers/order_controller.dart';
import 'package:gurkha_pasal/controllers/wishlist_controller.dart';
import 'package:gurkha_pasal/views/auth/login_screen.dart';
import 'package:gurkha_pasal/views/profile_screen/edit_profile_screen.dart';
import 'package:gurkha_pasal/views/profile_screen/followed_stores_screen.dart';
import 'package:gurkha_pasal/views/profile_screen/order_history_screen.dart';
import 'package:gurkha_pasal/views/profile_screen/wishlist_screen.dart';
import 'package:gurkha_pasal/views/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final WishlistController wishlistController =
        Get.find<WishlistController>();
    final FollowedStoresController followedStoresController =
        Get.find<FollowedStoresController>();
    final OrderController orderController = Get.find<OrderController>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: consts.darkFontGrey),
          onPressed: () {
            Get.back();
          },
        ),
        title:
            "My Profile".text
                .fontFamily(consts.bold)
                .size(22)
                .color(
                  const Color.fromARGB(255, 26, 25, 25).withOpacity(0.7),
                ) // Blur-like effect with opacity
                .make(),
        backgroundColor: consts.whiteColor,
        elevation: 3,
        shadowColor: Colors.grey.withOpacity(0.3),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info Section
              Container(
                padding: const EdgeInsets.all(20),
                color: consts.whiteColor,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: consts.lightGrey,
                      child:
                          user?.photoURL != null
                              ? ClipOval(
                                child: Image.network(
                                  user!.photoURL!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.person,
                                      size: 50,
                                      color: consts.fontGrey,
                                    );
                                  },
                                ),
                              )
                              : const Icon(
                                Icons.person,
                                size: 50,
                                color: consts.fontGrey,
                              ),
                    ),
                    16.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (user?.displayName ?? user?.email ?? "User").text
                              .fontFamily(consts.bold)
                              .size(20)
                              .color(const Color.fromARGB(255, 109, 105, 105))
                              .make(),
                          8.heightBox,
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const WishlistScreen());
                                },
                                child: Obx(
                                  () =>
                                      "${wishlistController.wishlistItems.length} Wishlist"
                                          .text
                                          .fontFamily(consts.regular)
                                          .size(14)
                                          .color(consts.primaryColor)
                                          .make(),
                                ),
                              ),
                              16.widthBox,
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const FollowedStoresScreen());
                                },
                                child: Obx(
                                  () =>
                                      "${followedStoresController.followedStores.length} Followed Stores"
                                          .text
                                          .fontFamily(consts.regular)
                                          .size(14)
                                          .color(consts.primaryColor)
                                          .make(),
                                ),
                              ),
                            ],
                          ),
                          8.heightBox,
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const EditProfileScreen());
                            },
                            child:
                                "Edit Profile".text
                                    .fontFamily(consts.semibold)
                                    .size(14)
                                    .color(consts.primaryColor)
                                    .make(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // My Orders Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "My Orders".text
                        .fontFamily(consts.bold)
                        .size(18)
                        .color(
                          const Color.fromARGB(
                            255,
                            70,
                            66,
                            66,
                          ).withOpacity(0.7),
                        ) // Blur-like effect
                        .make(),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const OrderHistoryScreen());
                      },
                      child:
                          "View All Orders".text
                              .fontFamily(consts.semibold)
                              .size(14)
                              .color(consts.primaryColor)
                              .make(),
                    ),
                  ],
                ),
              ),
              Container(
                color: consts.whiteColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(
                      () => _buildOrderIcon(
                        Icons.payment,
                        "To Pay",
                        orderController.orders
                            .where((order) => order.status == "Pending")
                            .length,
                      ),
                    ),
                    Obx(
                      () => _buildOrderIcon(
                        Icons.local_shipping,
                        "To Ship",
                        orderController.orders
                            .where((order) => order.status == "Shipped")
                            .length,
                      ),
                    ),
                    Obx(
                      () => _buildOrderIcon(
                        Icons.local_mall,
                        "To Receive",
                        orderController.orders
                            .where((order) => order.status == "Shipped")
                            .length,
                      ),
                    ),
                    Obx(
                      () => _buildOrderIcon(
                        Icons.rate_review,
                        "To Review",
                        orderController.orders
                            .where((order) => order.status == "Delivered")
                            .length,
                      ),
                    ),
                    Obx(
                      () => _buildOrderIcon(
                        Icons.cancel,
                        "Status",
                        orderController.orders
                            .where((order) => order.status == "Cancelled")
                            .length,
                      ),
                    ),
                  ],
                ),
              ),

              // Order Status Notification
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: consts.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      spreadRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: consts.greenColor,
                      size: 28,
                    ),
                    12.widthBox,
                    Expanded(
                      child:
                          "YAY! Your order has been delivered, we hope you like it..."
                              .text
                              .fontFamily(consts.regular)
                              .size(14)
                              .color(const Color.fromARGB(255, 138, 133, 133))
                              .make(),
                    ),
                    "15:57 Mar 02".text
                        .fontFamily(consts.regular)
                        .size(12)
                        .color(const Color.fromARGB(255, 139, 136, 136))
                        .make(),
                  ],
                ),
              ),

              // Promotional Cards (Gurkha Pasal Gems, Collect Vouchers)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.purple[800]!, Colors.purple[600]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 6,
                              spreadRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "GURKHA PASAL".text
                                .fontFamily(consts.bold)
                                .size(16)
                                .color(consts.whiteColor)
                                .make(),
                            4.heightBox,
                            "UP TO 20% OFF".text
                                .fontFamily(consts.bold)
                                .size(18)
                                .color(consts.whiteColor)
                                .make(),
                            4.heightBox,
                            "Check-in to earn 300 Gems".text
                                .fontFamily(consts.regular)
                                .size(14)
                                .color(consts.whiteColor)
                                .make(),
                            12.heightBox,
                            ourButton(
                              color: consts.orangeColor,
                              title: "Collect",
                              textColor: consts.whiteColor,
                              onPress: () {
                                Get.snackbar(
                                  "Gems",
                                  "Gems collection feature coming soon!",
                                );
                              },
                            ).box.width(100).height(40).make(),
                          ],
                        ),
                      ),
                    ),
                    12.widthBox,
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.pink[600]!, Colors.pink[400]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 6,
                              spreadRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Collect Vouchers".text
                                .fontFamily(consts.bold)
                                .size(16)
                                .color(consts.whiteColor)
                                .make(),
                            4.heightBox,
                            "Collect vouchers to get discounts!".text
                                .fontFamily(consts.regular)
                                .size(14)
                                .color(consts.whiteColor)
                                .make(),
                            12.heightBox,
                            ourButton(
                              color: consts.orangeColor,
                              title: "Collect",
                              textColor: consts.whiteColor,
                              onPress: () {
                                Get.snackbar(
                                  "Vouchers",
                                  "Voucher collection feature coming soon!",
                                );
                              },
                            ).box.width(100).height(40).make(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // List of Options
              16.heightBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildOptionTile(Icons.message, "My Messages", () {
                      Get.snackbar("Messages", "Messages feature coming soon!");
                    }),
                    _buildOptionTile(Icons.local_offer, "Buy Any 3", () {
                      Get.snackbar("Offers", "Buy Any 3 feature coming soon!");
                    }),
                    _buildOptionTile(
                      Icons.headset_mic,
                      "Contact Customer Care",
                      () {
                        Get.snackbar(
                          "Support",
                          "Customer Care feature coming soon!",
                        );
                      },
                    ),
                    _buildOptionTile(Icons.star, "My Reviews", () {
                      Get.snackbar(
                        "Reviews",
                        "My Reviews feature coming soon!",
                      );
                    }),
                    _buildOptionTile(Icons.help, "Help Center", () {
                      Get.snackbar("Help", "Help Center feature coming soon!");
                    }),
                    _buildOptionTile(Icons.store, "GurkhaLook", () {
                      Get.snackbar(
                        "GurkhaLook",
                        "GurkhaLook feature coming soon!",
                      );
                    }),
                    _buildOptionTile(Icons.group, "My Affiliates", () {
                      Get.snackbar(
                        "Affiliates",
                        "My Affiliates feature coming soon!",
                      );
                    }),
                    _buildOptionTile(Icons.payment, "Payment Options", () {
                      Get.snackbar(
                        "Payments",
                        "Payment Options feature coming soon!",
                      );
                    }),
                    24.heightBox,
                    // Logout Button
                    ourButton(
                      color: consts.redColor,
                      title: "Logout",
                      textColor: consts.whiteColor,
                      onPress: () async {
                        await FirebaseAuth.instance.signOut();
                        Get.offAll(() => const LoginScreen());
                      },
                    ).box.width(context.screenWidth - 32).make(),
                    32.heightBox,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for order icons
  Widget _buildOrderIcon(IconData icon, String label, int count) {
    return Column(
      children: [
        Stack(
          children: [
            Icon(icon, color: consts.orangeColor, size: 32),
            if (count > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: consts.redColor,
                    shape: BoxShape.circle,
                  ),
                  child:
                      count.text
                          .size(12)
                          .color(consts.whiteColor)
                          .fontFamily(consts.bold)
                          .make(),
                ),
              ),
          ],
        ),
        8.heightBox,
        label.text
            .fontFamily(consts.regular)
            .size(12)
            .color(consts.darkFontGrey)
            .make(),
      ],
    );
  }

  // Helper widget for option tiles
  Widget _buildOptionTile(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: consts.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: consts.fontGrey, size: 24),
            12.widthBox,
            Expanded(
              child:
                  title.text
                      .fontFamily(consts.regular)
                      .size(16)
                      .color(
                        const Color.fromARGB(255, 80, 77, 77).withOpacity(0.5),
                      ) // Blur-like effect
                      .make(),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color.fromARGB(255, 105, 102, 102),
            ),
          ],
        ),
      ),
    );
  }
}
