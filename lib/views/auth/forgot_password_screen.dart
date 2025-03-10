import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/views/widgets_common/bg_widget.dart';
import 'package:gurkha_pasal/views/widgets_common/custom_textfield.dart';
import 'package:gurkha_pasal/views/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final auth = FirebaseAuth.instance;

    void resetPassword() async {
      try {
        await auth.sendPasswordResetEmail(email: emailController.text.trim());
        Get.back(); // Go back to login screen
        Get.snackbar(
          "Success",
          "Password reset email sent successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: redColor,
          colorText: whiteColor,
        );
      } catch (e) {
        Get.snackbar(
          "Error",
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: redColor,
          colorText: whiteColor,
        );
      }
    }

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: "Forgot Password".text.fontFamily(bold).white.make(),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child:
              Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Enter your email to receive a password reset link"
                          .text
                          .white
                          .size(16)
                          .make()
                          .centered(),
                      20.heightBox,
                      customTextField(
                        title: email,
                        hint: emailHint,
                        controller: emailController,
                      ),
                      20.heightBox,
                      ourButton(
                        color: redColor,
                        title: "Send Reset Link",
                        textColor: whiteColor,
                        onPress: resetPassword,
                      ).box.width(context.screenWidth - 50).make(),
                    ],
                  ).box.white.rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
        ),
      ),
    );
  }
}
