import 'package:flutter/material.dart';

class DragTargetWidget extends StatelessWidget {
  final Function(String) onQuadrantDropped;

  const DragTargetWidget({required this.onQuadrantDropped});

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAccept: (data) => onQuadrantDropped(data), // Pass quadrant identifier to the parent
      builder: (context, candidateData, rejectedData) {
        return Container(
          height: 100,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border.all(color: Colors.black54, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Drag Quadrants Here', // Text prompt
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
