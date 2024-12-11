import 'dart:math';

import 'package:captain_ofthe_ship/task.dart';
import 'package:flutter/material.dart';

class ShipWheel extends StatelessWidget {
  final Quadrant? draggedQuadrant;

  ShipWheel({this.draggedQuadrant});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(300, 300),
      painter: ShipWheelPainter(draggedQuadrant),
      child: DragTarget<Quadrant>(
        builder: (context, candidateData, rejectedData) {
          return Container(
            width: 300,
            height: 300,
          );
        },
        onAccept: (quadrant) {
          // Handle task drop logic
        },
      ),
    );
  }
}

class ShipWheelPainter extends CustomPainter {
  final Quadrant? draggedQuadrant;

  ShipWheelPainter(this.draggedQuadrant);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.brown;

    // Draw the wheel outline
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    // Draw quadrant dividers
    paint.color = Colors.black;
    for (int i = 0; i < 4; i++) {
      canvas.drawLine(
        size.center(Offset.zero),
        size.center(Offset.fromDirection(i * (pi / 2), size.width / 2)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
