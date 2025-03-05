import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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
                      customTextField(title: name, hint: nameHint),
                      customTextField(title: email, hint: emailHint),
                      customTextField(title: password, hint: passwordHint),
                      customTextField(
                        title: retypePassword,
                        hint: passwordHint,
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
                                    text: termAndCondition,
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
                        onPress: () {},
                      ).box.width(context.screenWidth - 50).make(),
                      5.heightBox,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          alreadyHaveAccount.text.color(fontGrey).make(),
                          login.text.color(redColor).make().onTap((){
                            Get.back();
                          }),
                        ],
                      )
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
