import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  final Offset? startPoint;
  final Offset? endPoint;

  LinePainter(this.startPoint, this.endPoint);

  @override
  void paint(Canvas canvas, Size size) {
    if (startPoint == null || endPoint == null) return;

    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2.0;

    canvas.drawLine(startPoint!, endPoint!, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
