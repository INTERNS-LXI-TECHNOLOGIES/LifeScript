import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CircularMenuDemo(),
    );
  }
}

class CircularMenuDemo extends StatefulWidget {
  @override
  _CircularMenuDemoState createState() => _CircularMenuDemoState();
}

class _CircularMenuDemoState extends State<CircularMenuDemo> {
  Offset _position = Offset(150, 300);
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Circular Navigation Menu"),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          Positioned(
            left: _position.dx,
            top: _position.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _position += details.delta;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Circular menu options
                  if (_isMenuOpen) _buildCircularMenu(),
                  // Main toggle button
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _isMenuOpen = !_isMenuOpen;
                      });
                    },
                    backgroundColor: Colors.blue,
                    child: Icon(_isMenuOpen ? Icons.close : Icons.menu),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularMenu() {
    final double buttonDistance = 80.0; // Distance of buttons from center
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildMenuButton(Icons.home, "Home", Offset(-buttonDistance, 0)), // Left
        _buildMenuButton(Icons.camera_alt, "Camera", Offset(0, -buttonDistance)), // Top
        _buildMenuButton(Icons.alarm, "Alarm", Offset(buttonDistance, 0)), // Right
        _buildMenuButton(Icons.location_on, "Location", Offset(50, 75)), // Bottom-right
        _buildMenuButton(Icons.settings, "Settings", Offset(-30, 75)), // Bottom-left
      ],
    );
  }

  Widget _buildMenuButton(IconData icon, String tooltip, Offset offset) {
    return Transform.translate(
      offset: offset,
      child: FloatingActionButton(
        heroTag: tooltip,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$tooltip clicked!')),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(icon),
        tooltip: tooltip,
      ),
    );
  }
}
