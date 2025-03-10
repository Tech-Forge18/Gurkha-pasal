import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/views/widgets_common/applogo_widget.dart';
import 'package:gurkha_pasal/views/widgets_common/bg_widget.dart';
import 'package:gurkha_pasal/views/widgets_common/custom_textfield.dart';
import 'package:gurkha_pasal/views/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  bool _passwordVisible = false; // Track visibility of password
  bool _retypePasswordVisible = false; // Track visibility of retype password

  // Controllers for text fields
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final retypePasswordController = TextEditingController();

  // Firebase Auth instance
  final auth = FirebaseAuth.instance;

  // Signup function
  void handleSignup() async {
    if (isCheck != true) {
      Get.snackbar(
        "Error",
        "Please agree to the Terms & Conditions",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: redColor,
        colorText: whiteColor,
      );
      return;
    }

    if (passwordController.text != retypePasswordController.text) {
      Get.snackbar(
        "Error",
        "Passwords do not match",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: redColor,
        colorText: whiteColor,
      );
      return;
    }

    try {
      await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Get.back();
      Get.snackbar(
        "Success",
        "Account created successfully! Please log in.",
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

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Be a part of $appname".text
                  .fontFamily(bold)
                  .white
                  .size(18)
                  .make(),
              10.heightBox,
              Column(
                    children: [
                      customTextField(
                        title: name,
                        hint: nameHint,
                        controller: nameController,
                      ),
                      customTextField(
                        title: email,
                        hint: emailHint,
                        controller: emailController,
                      ),
                      customTextField(
                        title: password,
                        hint: passwordHint,
                        controller: passwordController,
                        isPass: true,
                        obscureText: !_passwordVisible, // Toggle visibility
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: fontGrey,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      customTextField(
                        title: retypePassword,
                        hint: passwordHint,
                        controller: retypePasswordController,
                        isPass: true,
                        obscureText:
                            !_retypePasswordVisible, // Toggle visibility
                        suffixIcon: IconButton(
                          icon: Icon(
                            _retypePasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: fontGrey,
                          ),
                          onPressed: () {
                            setState(() {
                              _retypePasswordVisible = !_retypePasswordVisible;
                            });
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: forgetPass.text.make(),
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: isCheck,
                            activeColor: redColor,
                            checkColor: whiteColor,
                            onChanged: (newValue) {
                              setState(() {
                                isCheck = newValue;
                              });
                            },
                          ),
                          10.heightBox,
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: fontGrey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: termsAndConditions,
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: redColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: fontGrey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: privacyPolicy,
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: redColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      10.heightBox,
                      ourButton(
                        color: isCheck == true ? redColor : lightGrey,
                        title: signup,
                        textColor: whiteColor,
                        onPress: handleSignup,
                      ).box.width(context.screenWidth - 50).make(),
                      5.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          alreadyHaveAccount.text.color(fontGrey).make(),
                          login.text.color(redColor).make().onTap(() {
                            Get.back();
                          }),
                        ],
                      ),
                    ],
                  ).box.white.rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}
