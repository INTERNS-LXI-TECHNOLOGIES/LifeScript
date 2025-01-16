import 'package:flutter/material.dart';

class CircularMenu extends StatefulWidget {
  final List<MenuButton> menuButtons;

  const CircularMenu({Key? key, required this.menuButtons}) : super(key: key);

  @override
  _CircularMenuState createState() => _CircularMenuState();
}

class _CircularMenuState extends State<CircularMenu> {
  Offset _position = Offset(0, 0); // Initialize _position
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    // Set the initial position to the bottom-right corner
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      setState(() {
        _position = Offset(size.width - 80, size.height - 160); // Adjust offset
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: _position.dx,
          top: _position.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _position += details.delta; // Enable drag
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
        ),
      ],
    );
  }

  Widget _buildCircularMenu() {
    return Stack(
      alignment: Alignment.center,
      children: widget.menuButtons.map((button) {
        return Transform.translate(
          offset: button.offset,
          child: FloatingActionButton(
            heroTag: button.tooltip,
            onPressed: button.onPressed,
            backgroundColor: button.color, // Use button's color
            child: Icon(button.icon),
            tooltip: button.tooltip,
          ),
        );
      }).toList(),
    );
  }
}

class MenuButton {
  final IconData icon;
  final String tooltip;
  final Offset offset;
  final VoidCallback onPressed;
  final Color color; // Added color property

  MenuButton({
    required this.icon,
    required this.tooltip,
    required this.offset,
    required this.onPressed,
    this.color = Colors.blue, // Default color
  });
}