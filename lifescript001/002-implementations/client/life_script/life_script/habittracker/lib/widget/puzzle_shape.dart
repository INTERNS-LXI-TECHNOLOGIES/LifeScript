import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PuzzleShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double notchSize = size.width * 0.2;
    
    path.moveTo(0, notchSize);
    path.quadraticBezierTo(size.width * 0.1, 0, size.width * 0.3, 0);
    path.quadraticBezierTo(size.width * 0.5, notchSize, size.width * 0.7, 0);
    path.quadraticBezierTo(size.width * 0.9, 0, size.width, notchSize);
    path.lineTo(size.width, size.height - notchSize);
    path.quadraticBezierTo(size.width * 0.9, size.height, size.width * 0.7, size.height);
    path.quadraticBezierTo(size.width * 0.5, size.height - notchSize, size.width * 0.3, size.height);
    path.quadraticBezierTo(size.width * 0.1, size.height, 0, size.height - notchSize);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DraggableShape extends StatelessWidget {
  final Color color;
  final ValueNotifier<Offset> positionNotifier = ValueNotifier(Offset(100, 100));

  DraggableShape({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Offset>(
      valueListenable: positionNotifier,
      builder: (context, position, child) {
        return Positioned(
          left: position.dx,
          top: position.dy,
          child: Draggable(
            feedback: ClipPath(
              clipper: PuzzleShape(),
              child: Container(
                width: 50,
                height: 50,
                color: color.withOpacity(0.5),
              ),
            ),
            childWhenDragging: Container(),
            onDragEnd: (details) {
              positionNotifier.value = details.offset;
            },
            child: ClipPath(
              clipper: PuzzleShape(),
              child: Container(
                width: 50,
                height: 50,
                color: color,
              ),
            ),
          ),
        );
      },
    );
  }
}

class DarkGlassmorphicUI extends StatelessWidget {
  final List<Color> colors = [Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.purple];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.black, Color(0xFF000033)],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
          ),
          ...List.generate(
            colors.length,
            (index) => DraggableShape(color: colors[index]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BlockBuilder(),
          ),
        ],
      ),
    );
  }
}

class BlockBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.black54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: DraggableShape(color: Colors.primaries[index]),
          );
        }),
      ),
    );
  }
}