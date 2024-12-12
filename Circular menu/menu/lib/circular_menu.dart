import 'package:flutter/material.dart';

class CircularMenu extends StatefulWidget {
  @override
  _CircularMenuState createState() => _CircularMenuState();
}

class _CircularMenuState extends State<CircularMenu> {
  Offset _position = Offset(150, 300);
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
            if (_isMenuOpen) _buildCircularMenu(),
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
    );
  }

  Widget _buildCircularMenu() {
    final double buttonDistance = 80.0;
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildMenuButton(Icons.home, "Home", Offset(-buttonDistance, 0)),
        _buildMenuButton(Icons.camera_alt, "Camera", Offset(0, -buttonDistance)),
        _buildMenuButton(Icons.alarm, "Alarm", Offset(buttonDistance, 0)),
        _buildMenuButton(Icons.location_on, "Location", Offset(50, 75)),
        _buildMenuButton(Icons.settings, "Settings", Offset(-30, 75)),
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
