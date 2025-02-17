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

    switch (shape.toLowerCase()) {
      case 'circle':
        _drawCircle(canvas, size, paint);
        break;
      case 'square':
        _drawSquare(canvas, size, paint);
        break;
      case 'triangle':
        _drawTriangle(canvas, size, paint);
        break;
      case 'star':
        _drawStar(canvas, size, paint);
        break;
      case 'book':
        _drawBook(canvas, size, paint);
        break;
      case 'running':
        _drawRunning(canvas, size, paint);
        break;
      case 'yoga':
        _drawYoga(canvas, size, paint);
        break;
      case 'computer':
        _drawComputer(canvas, size, paint);
        break;
      case 'brain':
        _drawBrain(canvas, size, paint);
        break;
      case 'breathing':
        _drawBreathing(canvas, size, paint);
        break;
      case 'hormones':
        _drawHormones(canvas, size, paint);
        break;
    
      default:
        _drawCustomShape(canvas, size, paint, shape);
    }
  }

  void _drawCircle(Canvas canvas, Size size, Paint paint) {
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, paint);
  }

  void _drawSquare(Canvas canvas, Size size, Paint paint) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  void _drawTriangle(Canvas canvas, Size size, Paint paint) {
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  void _drawStar(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    final double r = size.width / 4; // Reduced inner radius
    final double R = size.width / 2; // Reduced outer radius
    final double alpha = 2 * math.pi / 5;
    for (int i = 0; i < 5; i++) {
      path.lineTo(r * math.cos(alpha * i) + size.width / 2, r * math.sin(alpha * i) + size.height / 2);
      path.lineTo(R * math.cos(alpha * i + alpha / 2) + size.width / 2, R * math.sin(alpha * i + alpha / 2) + size.height / 2);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

 void _drawBook(Canvas canvas, Size size, Paint paint) {
  final path = Path();

  // Left cover
  path.moveTo(size.width * 0.1, size.height * 0.1);
  path.lineTo(size.width * 0.45, size.height * 0.2);
  path.lineTo(size.width * 0.45, size.height * 0.8);
  path.lineTo(size.width * 0.1, size.height * 0.9);
  path.close();
  canvas.drawPath(path, paint);

  // Right cover
  final path2 = Path();
  path2.moveTo(size.width * 0.55, size.height * 0.2);
  path2.lineTo(size.width * 0.9, size.height * 0.1);
  path2.lineTo(size.width * 0.9, size.height * 0.9);
  path2.lineTo(size.width * 0.55, size.height * 0.8);
  path2.close();
  canvas.drawPath(path2, paint);

  // Spine
  final spinePaint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;
  canvas.drawLine(Offset(size.width * 0.45, size.height * 0.2),
      Offset(size.width * 0.55, size.height * 0.2), spinePaint);
  canvas.drawLine(Offset(size.width * 0.45, size.height * 0.8),
      Offset(size.width * 0.55, size.height * 0.8), spinePaint);
}

void _drawRunning(Canvas canvas, Size size, Paint paint) {
  final path = Path()
    ..addOval(Rect.fromCircle(center: Offset(size.width / 2, size.height / 4), radius: size.width / 4)) // Increased head size
    ..moveTo(size.width / 2, size.height / 3) // Adjusted starting point for the body
    ..lineTo(size.width / 2, size.height * 1.2) // Increased body length
    ..lineTo(size.width * 0.7, size.height * 0.9) // Adjusted leg position
    ..moveTo(size.width / 3, size.height * 0.8) // Adjusted arm position
    ..lineTo(size.width * 1.2, size.height * 0.9) // Adjusted arm length
    ..moveTo(size.width / 3, size.height / 2) // Adjusted second arm position
    ..lineTo(size.width * 0.6, size.height * 0.7); // Adjusted second arm length
  canvas.drawPath(path, paint);
}


void _drawYoga(Canvas canvas, Size size, Paint paint) {
  final path = Path();

  double scale = 1.5; // Scale factor to increase size

  // Head
  canvas.drawCircle(
      Offset(size.width / 2, size.height / (6 / scale)),
      (size.width / 10) * scale,
      paint);

  // Body
  path.moveTo(size.width / 2, size.height / (4 / scale));
  path.lineTo(size.width / 2, size.height * (0.55 * scale));

  // Crossed Legs (Lotus Pose)
  path.moveTo(size.width * (0.4 - (0.1 * scale)), size.height * (0.7 * scale));
  path.quadraticBezierTo(size.width / 2, size.height * (0.8 * scale),
      size.width * (0.6 + (0.1 * scale)), size.height * (0.7 * scale));

  path.moveTo(size.width * (0.35 - (0.1 * scale)), size.height * (0.75 * scale));
  path.quadraticBezierTo(size.width / 2, size.height * (0.85 * scale),
      size.width * (0.65 + (0.1 * scale)), size.height * (0.75 * scale));

  // Arms resting on knees (Relaxed Position)
  path.moveTo(size.width * 0.5, size.height * (0.45 * scale));
  path.quadraticBezierTo(size.width * (0.3 - (0.1 * scale)),
      size.height * (0.6 * scale), size.width * (0.35 - (0.1 * scale)),
      size.height * (0.7 * scale));

  path.moveTo(size.width * 0.5, size.height * (0.45 * scale));
  path.quadraticBezierTo(size.width * (0.7 + (0.1 * scale)),
      size.height * (0.6 * scale), size.width * (0.65 + (0.1 * scale)),
      size.height * (0.7 * scale));

  canvas.drawPath(path, paint);
}


  void _drawComputer(Canvas canvas, Size size, Paint paint) {
    canvas.drawRect(Rect.fromLTWH(size.width * 0.2, size.height * 0.2, size.width * 0.6, size.height * 0.4), paint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.3, size.height * 0.7, size.width * 0.4, size.height * 0.1), paint);
  }

  void _drawBrain(Canvas canvas, Size size, Paint paint) {
    canvas.drawOval(Rect.fromLTWH(size.width * 0.2, size.height * 0.2, size.width * 0.6, size.height * 0.6), paint);
  }

  void _drawBreathing(Canvas canvas, Size size, Paint paint) {
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..cubicTo(size.width, size.height / 2, size.width / 2, size.height, 0, size.height / 2);
    canvas.drawPath(path, paint);
  }

  void _drawHormones(Canvas canvas, Size size, Paint paint) {
    canvas.drawCircle(Offset(size.width / 3, size.height / 3), size.width / 6, paint);
    canvas.drawCircle(Offset(size.width * 2 / 3, size.height / 3), size.width / 6, paint);
    canvas.drawCircle(Offset(size.width / 2, size.height * 2 / 3), size.width / 6, paint);
    canvas.drawLine(Offset(size.width / 3 + size.width / 6, size.height / 3), Offset(size.width / 2 - size.width / 6, size.height * 2 / 3), paint);
    canvas.drawLine(Offset(size.width * 2 / 3 - size.width / 6, size.height / 3), Offset(size.width / 2 + size.width / 6, size.height * 2 / 3), paint);
  }
  void _drawCustomShape(Canvas canvas, Size size, Paint paint, String shape) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
