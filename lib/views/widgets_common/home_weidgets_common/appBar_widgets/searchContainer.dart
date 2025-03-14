import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    required this.backgroundColor,
    required this.prefixIcon,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final Color backgroundColor;
  final Icon prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: showBackground ? backgroundColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: showBorder ? Border.all(color: Colors.grey) : null,
        ),
        child: Row(
          children: [
            prefixIcon, // Using the provided prefixIcon instead of hardcoded Icon
            const SizedBox(width: 16),
            Text(text, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
