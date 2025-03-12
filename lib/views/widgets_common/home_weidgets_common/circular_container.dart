import 'package:flutter/material.dart';



class CircularContainer extends StatelessWidget {
  const CircularContainer({super.key, 
  this.height ,
  this.width,
  required this.radius ,
   this.padding,

 this .margine,
   this.child,
     this.backgroundColor =Colors.white,
     this.showBorder =false, 
      this.borderColor = Colors.white,
  
  
  });

  final EdgeInsetsGeometry? margine;
  final EdgeInsetsGeometry ? padding ;
  final double? height;
  final double? width;
  final double radius;
  final bool showBorder ;
  final Color backgroundColor ;
  final Widget? child;
  final Color borderColor ;
 

  @override
  Widget build(BuildContext context) {
    return Container(
margin: margine,
width: width,
height: height,
padding: padding,
decoration: BoxDecoration(
  color: backgroundColor,
  borderRadius: BorderRadius.circular(radius),
  border: showBorder ? Border.all(color: borderColor) : null,
),
child: child,
    );
  }
}   