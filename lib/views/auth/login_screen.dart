import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/consts/list.dart';
import 'package:gurkha_pasal/views/auth/signup_screen.dart';
import 'package:gurkha_pasal/views/home_screen/home.dart';
import 'package:gurkha_pasal/views/widgets_common/applogo_widget.dart';
import 'package:gurkha_pasal/views/widgets_common/bg_widget.dart';
import 'package:gurkha_pasal/views/widgets_common/custom_textfield.dart';
import 'package:gurkha_pasal/views/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
              10.heightBox,
              Column(
                    children: [
                      customTextField(title: email, hint: emailHint),
                      customTextField(title: password, hint: passwordHint),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: forgetPass.text.make(),
                        ),
                      ),
                      5.heightBox,
                      ourButton(
                        color: redColor,
                        title: login,
                        textColor: whiteColor,
                        onPress: () {
                          Get.to(() => const Home());
                        },
                      ).box.width(context.screenWidth - 50).make(),

                      15.heightBox,
                      createNewAccount.text.color(fontGrey).make(),

                      ourButton(
                        color: lightGolden,
                        title: signup,
                        textColor: redColor,
                        onPress: () {
                          Get.to(() => const SignupScreen());
                        },
                      ).box.width(context.screenWidth - 50).make(),
                      10.heightBox,

                      loginWith.text.color(fontGrey).make(),
                      5.heightBox,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: lightGrey,
                              radius: 25,
                              child: Image.asset(
                                socialIconList[index],
                                width: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).box.white.rounded
                  .padding(EdgeInsets.all(16))
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
