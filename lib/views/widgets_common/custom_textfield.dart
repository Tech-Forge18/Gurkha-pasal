import 'package:flutter/material.dart';
import 'package:gurkha_pasal/consts/consts.dart';

Widget customTextField({String? title, String? hint, TextEditingController? controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      10.heightBox,
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(fontFamily: semibold, color: fontGrey),
          hintText: hint,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Consistent padding
          fillColor: lightGrey,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
            borderSide: BorderSide.none, // No border by default
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Consistent rounded corners
            borderSide: const BorderSide(color: redColor, width: 2), // Border when focused
          ),
        ),
      ),
      10.heightBox,
    ],
  );
}
