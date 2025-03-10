import 'package:flutter/material.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/curve_edges.dart';


class CurveEdgeWidget extends StatelessWidget {
  const CurveEdgeWidget({
    super.key, this.child,
  });
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath( 
      clipper: CustomCurveEdges(),
      child: child,
    );
  }
}