import 'dart:convert';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CrystalBallDemo(),
    );
  }
}

class CrystalBallDemo extends StatefulWidget {
  @override
  _CrystalBallDemoState createState() => _CrystalBallDemoState();
}

class _CrystalBallDemoState extends State<CrystalBallDemo>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> quadrants = [];
  String feedbackMessage = "Drag a task to the crystal ball.";
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    // Load JSON data (Simulated here for demo purposes)
    String jsonData = '''
    [
      {"quadrant": "Quadrant I", "feedback": "Bright future ahead!"},
      {"quadrant": "Quadrant II", "feedback": "Good choice!"},
      {"quadrant": "Quadrant III", "feedback": "Be cautious!"},
      {"quadrant": "Quadrant IV", "feedback": "Time wasted!"}
    ]
    ''';
    quadrants = List<Map<String, dynamic>>.from(json.decode(jsonData));

    // Initialize animation for crystal ball glow
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crystal Ball of Priorities"),
        backgroundColor: Colors.purple.shade800,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade800, Colors.pink.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: quadrants.map((quadrant) {
                  return Expanded(
                    child: DragTarget<String>(
                      onAccept: (data) {
                        setState(() {
                          feedbackMessage = quadrant['feedback'];
                        });
                      },
                      builder: (context, candidateData, rejectedData) {
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              quadrant['quadrant'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                ScaleTransition(
                  scale: Tween(begin: 1.0, end: 1.1).animate(CurvedAnimation(
                    parent: _animationController!,
                    curve: Curves.easeInOut,
                  )),
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white,
                          feedbackMessage.contains("Bright")
                              ? Colors.greenAccent.shade400
                              : feedbackMessage.contains("Good")
                                  ? Colors.blueAccent.shade100
                                  : Colors.red.shade200,
                        ],
                        radius: 0.6,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.6),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        feedbackMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Draggable<String>(
              data: "Task",
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.6),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Task",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              feedback: Material(
                color: Colors.transparent,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withOpacity(0.5),
                  ),
                  child: const Center(
                    child: Text(
                      "Dragging...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              childWhenDragging: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: const Center(
                  child: Text(
                    "Task",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
