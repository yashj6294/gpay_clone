import 'package:flutter/material.dart';

class TickPainter extends CustomPainter {
  final double position;
  TickPainter({
    required this.position,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4.0;
    var center = size / 2;
    var distance1 = position * 20 * 2;
    var distance2 = (position - .5) * 45 * 2;
    var point1 = Offset(center.width - 20, center.height - 20);
    var point2 = Offset(center.width + distance2, center.height - distance2);
    if (position <= 0.5) {
      canvas.drawLine(
          point1, Offset(point1.dx + distance1, point1.dy + distance1), paint);
    }
    if (position >= 0.5) {
      canvas.drawLine(point1, Offset(center.width, center.height), paint);
      canvas.drawLine(Offset(center.width, center.height), point2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
