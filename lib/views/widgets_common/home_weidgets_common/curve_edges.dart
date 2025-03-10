import 'package:flutter/material.dart';



class CustomCurveEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
  
  final firstCurve = Offset(0, size.height - 20);
  final lastCurve = Offset(30, size.height - 20);
  path.quadraticBezierTo(firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy); //path.quadraticBezierTo(x1, y1, x2, y2)


  final secondfirstCurve = Offset(size.width, size.height - 20);
  final secondlastCurve = Offset(size.width-30, size.height-20);
  path.quadraticBezierTo(secondfirstCurve.dx, secondfirstCurve.dy, secondlastCurve.dx, secondlastCurve.dy);
  final thirdfirstCurve = Offset(size.width, size.height - 20);
  final thirdlastCurve = Offset(size.width, size.height);
  path.quadraticBezierTo(thirdfirstCurve.dx, thirdfirstCurve.dy, thirdlastCurve.dx, thirdlastCurve.dy); 

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
/*************  ✨ Codeium Command ⭐  *************/
  /// Determines whether the clip needs to be updated when the new instance of
  /// the custom clipper is different from the old instance.
  ///
  /// Always returns true, indicating that the clip should be recalculated
  /// whenever the widget is rebuilt with a new instance of the clipper.

/******  ba424cee-389e-4b98-b237-ba1f7f353d75  *******/
  bool shouldReclip(covariant CustomClipper<Path> oldClipper)
  
  {return true;} //=> false;
}