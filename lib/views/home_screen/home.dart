// lib/views/home.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/views/cart_screen/cart.dart';
import 'package:gurkha_pasal/views/category_screen/all_categories_screen.dart';
import 'package:gurkha_pasal/views/home_screen/home_screen.dart';
import 'package:gurkha_pasal/views/messages_screen/messages.dart';
import 'package:gurkha_pasal/views/profile_screen/profile.dart';

class HomeController extends GetxController {
  var currentNavIndex = 2.obs; // Default to Home
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    print('Home: Building...');
    var controller = Get.put(HomeController());

    var navBarItem = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.category),
        label: 'Categories',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.message),
        label: 'Messages',
      ),
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        label: 'Cart',
      ),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
    ];

    var navBody = [
      const CategoriesScreen(),
      const MessagesScreen(),
      const HomeScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 107, 13),
      body: Obx(() {
        print(
          'Home: Rendering body at index ${controller.currentNavIndex.value}',
        );
        return navBody.elementAt(controller.currentNavIndex.value);
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          selectedItemColor: primaryColor,
          unselectedItemColor: const Color.fromARGB(255, 134, 133, 133),
          selectedLabelStyle: const TextStyle(fontFamily: semibold),
          unselectedLabelStyle: const TextStyle(fontFamily: regular),
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255, 206, 200, 200),
          items: navBarItem,
          onTap: (value) {
            print('Home: Switching to index $value');
            controller.currentNavIndex.value = value;
          },
        ),
      ),
    );
  }
}
