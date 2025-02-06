import 'dart:ui';
import 'package:flutter/material.dart';

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

class DraggableShape extends StatefulWidget {
  final Color color;
  final String text;
  final Function(String) onTextChanged;

  DraggableShape({Key? key, required this.color, required this.text, required this.onTextChanged}) : super(key: key);

  @override
  _DraggableShapeState createState() => _DraggableShapeState();
}

class _DraggableShapeState extends State<DraggableShape> {
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: widget.text,
      feedback: ClipPath(
        clipper: PuzzleShape(),
        child: Container(
          width: 80,
          height: 80,
          color: widget.color.withOpacity(0.5),
          child: Center(child: Text(widget.text, style: TextStyle(color: Colors.white, fontSize: 16))),
        ),
      ),
      childWhenDragging: Container(),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Enter Text"),
              content: TextField(
                controller: textController,
                decoration: InputDecoration(hintText: "Type here"),
                onChanged: widget.onTextChanged,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("OK"),
                ),
              ],
            ),
          );
        },
        child: ClipPath(
          clipper: PuzzleShape(),
          child: Container(
            width: 80,
            height: 80,
            color: widget.color,
            child: Center(child: Text(widget.text, style: TextStyle(color: Colors.white, fontSize: 16))),
          ),
        ),
      ),
    );
  }
}

class DarkGlassmorphicUI extends StatefulWidget {
  @override
  _DarkGlassmorphicUIState createState() => _DarkGlassmorphicUIState();
}

class _DarkGlassmorphicUIState extends State<DarkGlassmorphicUI> {
  final List<String> bottomPuzzleTexts = ["A", "B", "C", "D", "E"];

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
          Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DraggableShape(
                        color: Colors.primaries[index],
                        text: "",
                        onTextChanged: (text) {},
                      ),
                    );
                  }),
                ),
              ),
              BlockBuilder(
                bottomPuzzleTexts: bottomPuzzleTexts,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    final item = bottomPuzzleTexts.removeAt(oldIndex);
                    bottomPuzzleTexts.insert(newIndex, item);
                  });
                },
                onDrop: (text) {
                  setState(() {
                    bottomPuzzleTexts.add(text);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BlockBuilder extends StatelessWidget {
  final List<String> bottomPuzzleTexts;
  final Function(int, int) onReorder;
  final Function(String) onDrop;

  BlockBuilder({required this.bottomPuzzleTexts, required this.onReorder, required this.onDrop});

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAccept: (text) => onDrop(text),
      builder: (context, candidateData, rejectedData) {
        return Container(
          height: 100,
          color: Colors.black54,
          child: ReorderableListView(
            scrollDirection: Axis.horizontal,
            onReorder: onReorder,
            children: List.generate(bottomPuzzleTexts.length, (index) {
              return DraggableShape(
                key: ValueKey(bottomPuzzleTexts[index]),
                color: Colors.primaries[index % Colors.primaries.length],
                text: bottomPuzzleTexts[index],
                onTextChanged: (text) {},
              );
            }),
          ),
        );
      },
    );
  }
}
