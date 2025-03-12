import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/views/cart_screen/cart.dart';
import 'package:gurkha_pasal/views/category_screen/category_screen.dart';
import 'package:gurkha_pasal/views/home_screen/home_screen.dart';
import 'package:gurkha_pasal/views/messages_screen/messages.dart'; // Import MessagesScreen
import 'package:gurkha_pasal/views/profile_screen/profile.dart';

// Define the HomeController
class HomeController extends GetxController {
  var currentNavIndex = 2.obs; // Default to Home (center)
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navBarItem = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.category), // Categories
        label: 'Categories',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.message), // Messages
        label: 'Messages',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.home), // Home (center)
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart), // Cart
        label: 'Cart',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person), // Account
        label: 'Account',
      ),
    ];

    var navBody = [
      const CategoryScreen(), // Index 0
      const MessagesScreen(), // Index 1 (Messages)
      const HomeScreen(), // Index 2 (center)
      const CartScreen(), // Index 3
      const ProfileScreen(), // Index 4
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        221,
        107,
        13,
      ), // Explicitly set background
      body: Obx(() => navBody.elementAt(controller.currentNavIndex.value)),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          selectedItemColor: primaryColor, // Match your example
          unselectedItemColor: const Color.fromARGB(
            255,
            134,
            133,
            133,
          ), // Match your example
          selectedLabelStyle: const TextStyle(fontFamily: semibold),
          unselectedLabelStyle: const TextStyle(fontFamily: regular),
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(
            255,
            206,
            200,
            200,
          ), // Match the Scaffold background
          items: navBarItem,
          onTap: (value) {
            controller.currentNavIndex.value = value;
          },
        ),
      ),
    );
  }
}
