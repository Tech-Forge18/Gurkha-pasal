import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Simplified import
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/consts/images.dart';
import 'package:gurkha_pasal/views/auth/login_screen.dart';
import 'package:gurkha_pasal/views/widgets_common/applogo_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key}); // Updated to use super.key

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(
        () => const LoginScreen(),
      ); // Changed to Get.off for cleaner navigation
    });
  }

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg, width: 300),
            ),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(20).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            const Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}
