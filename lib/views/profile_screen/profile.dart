import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/views/auth/login_screen.dart';
import 'package:gurkha_pasal/views/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background like Daraz
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info Section
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: lightGrey,
                      child: Icon(Icons.person, size: 40, color: fontGrey),
                    ),
                    10.widthBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (user?.email ?? "User").text
                            .fontFamily(bold)
                            .size(18)
                            .black
                            .make(),
                        5.heightBox,
                        Row(
                          children: [
                            "0 Wishlist".text
                                .fontFamily(regular)
                                .size(14)
                                .color(fontGrey)
                                .make(),
                            10.widthBox,
                            "3 Followed Stores".text
                                .fontFamily(regular)
                                .size(14)
                                .color(fontGrey)
                                .make(),
                            10.widthBox,
                            "3 Vouchers".text
                                .fontFamily(regular)
                                .size(14)
                                .color(fontGrey)
                                .make(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // My Orders Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "My Orders".text.fontFamily(bold).size(18).black.make(),
                    "VIEW ALL ORDERS".text
                        .fontFamily(regular)
                        .size(14)
                        .color(primaryColor)
                        .make(),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildOrderIcon(Icons.payment, "To Pay"),
                    _buildOrderIcon(Icons.local_shipping, "To Ship"),
                    _buildOrderIcon(Icons.local_mall, "To Receive"),
                    _buildOrderIcon(Icons.rate_review, "To Review"),
                    _buildOrderIcon(Icons.cancel, "Status"),
                  ],
                ),
              ),

              // Order Status Notification
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green),
                    10.widthBox,
                    Expanded(
                      child:
                          "YAY! Your order has been delivered, we hope you like it..."
                              .text
                              .fontFamily(regular)
                              .size(14)
                              .black
                              .make(),
                    ),
                    "15:57 Mar 02".text
                        .fontFamily(regular)
                        .size(12)
                        .color(fontGrey)
                        .make(),
                  ],
                ),
              ),

              // Promotional Cards (Daraz Gems, Collect Vouchers)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.purple[800],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "GURKHA PASAL".text.fontFamily(bold).white.make(),
                            5.heightBox,
                            "UP TO 20% OFF".text.fontFamily(bold).white.make(),
                            "Check-in to earn 300 Gems".text
                                .fontFamily(regular)
                                .white
                                .make(),
                            10.heightBox,
                            ourButton(
                              color: Colors.orange,
                              title: "Collect",
                              textColor: whiteColor,
                              onPress: () {},
                            ).box.width(100).make(),
                          ],
                        ),
                      ),
                    ),
                    10.widthBox,
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.pink[600],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Collect Vouchers".text
                                .fontFamily(bold)
                                .white
                                .make(),
                            5.heightBox,
                            "Collect vouchers to get discounts!".text
                                .fontFamily(regular)
                                .white
                                .make(),
                            10.heightBox,
                            ourButton(
                              color: Colors.orange,
                              title: "Collect",
                              textColor: whiteColor,
                              onPress: () {},
                            ).box.width(100).make(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // List of Options
              20.heightBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildOptionTile(Icons.message, "My Messages"),
                    _buildOptionTile(Icons.local_offer, "Buy Any 3"),
                    _buildOptionTile(
                      Icons.headset_mic,
                      "Contact Customer Care",
                    ),
                    _buildOptionTile(Icons.star, "My Reviews"),
                    _buildOptionTile(Icons.help, "Help Center"),
                    _buildOptionTile(Icons.store, "GurkhaLook"),
                    _buildOptionTile(Icons.group, "My Affiliates"),
                    _buildOptionTile(Icons.payment, "Payment Options"),
                    20.heightBox,
                    // Logout Button
                    ourButton(
                      color: redColor,
                      title: "Logout",
                      textColor: whiteColor,
                      onPress: () async {
                        await FirebaseAuth.instance.signOut();
                        Get.offAll(() => const LoginScreen());
                      },
                    ).box.width(context.screenWidth - 50).make(),
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
  Widget _buildOrderIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.orange, size: 30),
        5.heightBox,
        label.text.fontFamily(regular).size(12).black.make(),
      ],
    );
  }

  // Helper widget for option tiles
  Widget _buildOptionTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          10.widthBox,
          title.text.fontFamily(regular).size(16).black.make(),
        ],
      ),
    );
  }
}
