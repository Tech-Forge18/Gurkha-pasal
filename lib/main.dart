import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/models/product.dart'; // Updated to match your file name
import 'package:gurkha_pasal/views/splash_scree/splash_screen.dart';
import 'package:gurkha_pasal/views/auth/login_screen.dart';
import 'package:gurkha_pasal/views/auth/signup_screen.dart';
import 'package:gurkha_pasal/views/home_screen/home.dart';
import 'package:gurkha_pasal/views/product_screen/product_listing.dart';
import 'package:gurkha_pasal/views/product_screen/product_details.dart';
import 'package:gurkha_pasal/views/cart_screen/cart.dart';
import 'package:gurkha_pasal/views/profile_screen/profile.dart';
import 'package:gurkha_pasal/controllers/product_controller.dart';
import 'package:gurkha_pasal/controllers/cart_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Firebase initialization failed: $e");
  }

  // Initialize controllers
  Get.put(ProductController());
  Get.put(CartController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        fontFamily: regular,
      ),
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/signup', page: () => const SignupScreen()),
        GetPage(name: '/home', page: () => const Home()),
        GetPage(
          name: '/product_listing',
          page: () {
            final String category = Get.arguments ?? '';
            return ProductScreen(category: category);
          },
        ),
        GetPage(
          name: '/product_details',
          page: () {
            final Product product = Get.arguments as Product;
            return ProductDetailsScreen(
              product: product,
            ); // Pass product via constructor
          },
        ),
        GetPage(name: '/cart', page: () => const CartScreen()),
        GetPage(name: '/profile', page: () => const ProfileScreen()),
      ],
    );
  }
}
