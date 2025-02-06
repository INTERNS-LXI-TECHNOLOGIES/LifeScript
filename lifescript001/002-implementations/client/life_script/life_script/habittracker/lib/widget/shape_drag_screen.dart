import 'package:flutter/material.dart';


class ShapeDragScreen extends StatefulWidget {
  @override
  _ShapeDragScreenState createState() => _ShapeDragScreenState();
}

class _ShapeDragScreenState extends State<ShapeDragScreen> {
  List<Widget> shapes = [];
  Offset _position = Offset(100, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop Shapes'),
      ),
      body: Stack(
        children: [
          Positioned(
            left: _position.dx,
            top: _position.dy,
            child: Draggable(
              feedback: CircleShape(),
              child: CircleShape(),
              childWhenDragging: Container(),
              onDragEnd: (details) {
                setState(() {
                  _position = details.offset;
                });
              },
            ),
          ),
          Positioned(
            left: 200,
            top: 200,
            child: Draggable(
              feedback: SquareShape(),
              child: SquareShape(),
              childWhenDragging: Container(),
              onDragEnd: (details) {
                setState(() {
                  _position = details.offset;
                });
              },
            ),
          ),
          Positioned(
            left: 300,
            top: 300,
            child: Draggable(
              feedback: TriangleShape(),
              child: TriangleShape(),
              childWhenDragging: Container(),
              onDragEnd: (details) {
                setState(() {
                  _position = details.offset;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CircleShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
    );
  }
}

class SquareShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.red,
    );
  }
}

class TriangleShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(100, 100),
      painter: TrianglePainter(),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}