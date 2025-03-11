import 'package:flutter/material.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:velocity_x/velocity_x.dart';

Widget ourButton({
  required VoidCallback onPress,
  required Color color,
  required Color textColor,
  required String title,
  Icon? icon, // Make icon optional
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    onPressed: onPress,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          // Conditionally show icon
          icon,
          8.widthBox,
        ],
        title.text.color(textColor).fontFamily(bold).size(16).make(),
      ],
    ),
  );
}
