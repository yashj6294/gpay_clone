import 'dart:math';

import 'package:flutter/material.dart';

class PacManPainter extends CustomPainter {
  final double fraction;

  PacManPainter(this.fraction);

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double angle = fraction * pi * 0.8;
    final Paint paint = Paint()..color = Colors.white;
    canvas.drawArc(
      Rect.fromCenter(
          center: Offset(centerX, centerY),
          width: size.width,
          height: size.height),
      angle / 2,
      2 * pi - angle,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
