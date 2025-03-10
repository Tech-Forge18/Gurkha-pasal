import 'package:flutter/material.dart';



class CircularContainer extends StatelessWidget {
  const CircularContainer({super.key, 
  this.height =350,
   this.width =350, 
 this.radius =350, 
 this.padding =0,
 this .margine,
   this.child,
     this.backgroundColor =Colors.white,
  
  
  });

  final EdgeInsets? margine;
  final double? height;
  final double? width;
  final double radius;
  final double padding ;
  final Widget? child;
  final Color backgroundColor ;

  @override
  Widget build(BuildContext context) {
    return Container(
margin: margine,
width: width,
height: height,
padding: EdgeInsets.all(padding),
decoration: BoxDecoration(
  color: backgroundColor,
  borderRadius: BorderRadius.circular(radius),
),
child: child,
    );
  }
}   