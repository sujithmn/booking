import 'package:flutter/material.dart';

class FlowDemoDelegate extends FlowDelegate {

  FlowDemoDelegate({required this.myAnimation}) : super(repaint: myAnimation);

  final Animation<double> myAnimation;

  @override
  bool shouldRepaint(FlowDemoDelegate oldDelegate) {
    return myAnimation != oldDelegate.myAnimation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = context.childCount - 1; i >= 0; i--) {
      double? d = context.getChildSize(i)?.height;
      double dx = (d! + 10) * i;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(0, dx * myAnimation.value + 10, 0),
      );
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(70.0, double.infinity);
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return i == 0 ? constraints : BoxConstraints.tight(const Size(50.0, 50.0));
  }
}