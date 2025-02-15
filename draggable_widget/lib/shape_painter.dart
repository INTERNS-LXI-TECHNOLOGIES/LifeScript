import 'package:flutter/material.dart';
import 'dart:math' as math;

class ShapePainter extends CustomPainter {
  final String shape;
  final Color color;

  ShapePainter({required this.shape, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    switch (shape) {
      case 'circle':
        canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, paint);
        break;
      case 'square':
        canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
        break;
      case 'triangle':
        final path = Path()
          ..moveTo(size.width / 2, 0)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();
        canvas.drawPath(path, paint);
        break;
      case 'star':
        final path = Path();
        final double r = size.width / 2;
        final double R = size.width;
        final double alpha = 2 * math.pi / 5;
        for (int i = 0; i < 5; i++) {
          path.lineTo(r * math.cos(alpha * i), r * math.sin(alpha * i));
          path.lineTo(R * math.cos(alpha * i + alpha / 2), R * math.sin(alpha * i + alpha / 2));
        }
        path.close();
        canvas.drawPath(path, paint);
        break;
      case 'book':
        final path = Path()
          ..moveTo(0, 0)
          ..lineTo(size.width, 0)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();
        canvas.drawPath(path, paint);
        break;
      default:
        canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    }
  }

  @override
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}