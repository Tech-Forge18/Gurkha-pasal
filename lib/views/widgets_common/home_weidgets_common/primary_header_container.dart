import 'package:flutter/material.dart';
import 'package:gurkha_pasal/consts/colors.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/circular_container.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/curve_edgeswidget.dart';



class PrimaryHeaderWidgets extends StatelessWidget {
  const PrimaryHeaderWidgets({
    super.key, required this.child, required this.height,
  });
  final Widget child;
  final double height ;

  @override
  Widget build(BuildContext context) {
    return CurveEdgeWidget(
      child:Container(
            color: Colors.deepOrange,
            padding: const EdgeInsets.all(0),
            child: SizedBox(
              height: height,
              child: Stack(
    children: [
      Positioned(
        top: -150,
        right: -250,
        child: CircularContainer(
          backgroundColor: whiteColor.withOpacity(0.1),
          height: 350,
          width: 350,
          radius: 350,
        ),
      ),
      Positioned(
        top: 100,
        right: -300,
        child: CircularContainer(
          backgroundColor: whiteColor.withOpacity(0.1),
          height: 350,
          width: 350,
          radius: 350,
        ),
      ),
      child ,
    ],
              ),
            ),
          ),
    );
  }
}


