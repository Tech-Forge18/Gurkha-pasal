import 'package:flutter/material.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customTextField({
  String? title,
  String? hint,
  TextEditingController? controller,
  bool isPass = false, // Optional, defaults to false
  bool obscureText = false, // New parameter for visibility control
  Widget? suffixIcon, // New parameter for adding toggle button
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      10.heightBox,
      TextFormField(
        controller: controller,
        obscureText:
            isPass ? obscureText : false, // Use obscureText if isPass is true
        decoration: InputDecoration(
          hintStyle: TextStyle(fontFamily: semibold, color: fontGrey),
          hintText: hint,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          fillColor: lightGrey,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: redColor, width: 2),
          ),
          suffixIcon: suffixIcon, // Add the suffix icon here
        ),
      ),
      10.heightBox,
    ],
  );
}
