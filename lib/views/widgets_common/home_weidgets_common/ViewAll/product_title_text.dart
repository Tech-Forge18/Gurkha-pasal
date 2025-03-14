import 'package:flutter/material.dart';



class ProductTitleText extends StatelessWidget {
  const ProductTitleText({
super.key,
  required this.title,
  
  this.maxLines = 2,
    // this.textAlign = TextAlign.left,
 
  }) ;

  final String title; 

  final int maxLines;
  // final TextAlign? textAlign;


  @override
  Widget build(BuildContext context) {  
    return Text(
      title,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      // textAlign: textAlign,
      style : TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),

    );
   
  }
}