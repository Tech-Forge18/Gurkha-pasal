import 'package:flutter/material.dart';


class CircularIcon extends StatelessWidget {
  const CircularIcon({
    super.key,
     this.height,
      this.width,
       this.size = 30, 
       this.backgroundColor,
        this.color,
         required this.icon,
          this.onPressed,
  });

  final double? height, width,size;
  final Color? backgroundColor;
  final Color? color;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(onPressed: onPressed, icon:  Icon(icon ,color: color, size: size)),
    );
  }
}