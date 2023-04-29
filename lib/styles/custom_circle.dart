import 'package:flutter/material.dart';

class CustomCircle extends CustomPainter {

  final Color circleColor;
  final double horizontalOffset;
  final double verticalOffset;
  final double circleSize;

  CustomCircle({
    required this.circleColor,
    required this.horizontalOffset,
    required this.verticalOffset,
    required this.circleSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var painter = Paint()
      ..color = circleColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(horizontalOffset, verticalOffset), circleSize, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}