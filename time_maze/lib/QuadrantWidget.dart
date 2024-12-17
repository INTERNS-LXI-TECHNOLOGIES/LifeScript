import 'package:flutter/material.dart';

class QuadrantWidget extends StatelessWidget {
  final String label;
  final Color color;

  const QuadrantWidget({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: label,
      feedback: _buildQuadrant(),
      child: _buildQuadrant(),
      childWhenDragging: _buildQuadrant(faded: true),
    );
  }

  Widget _buildQuadrant({bool faded = false}) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: faded ? Colors.grey : color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black45),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
