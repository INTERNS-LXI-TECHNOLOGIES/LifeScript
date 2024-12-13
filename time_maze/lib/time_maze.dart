import 'package:flutter/material.dart';

void main() {
  runApp(TimeManagementMazeApp());
}

class TimeManagementMazeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Management Maze',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MazeGamePage(),
    );
  }
}

class MazeGamePage extends StatefulWidget {
  @override
  _MazeGamePageState createState() => _MazeGamePageState();
}

class _MazeGamePageState extends State<MazeGamePage> {
  String draggedItem = "";

  void handleDrag(String item) {
    setState(() {
      draggedItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop Maze'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Draggable<String>(
                  data: "happy",
                  feedback: Icon(
                    Icons.sentiment_satisfied_alt,
                    color: Colors.green,
                    size: 50,
                  ),
                  child: Icon(
                    Icons.sentiment_satisfied_alt,
                    color: Colors.green,
                    size: 50,
                  ),
                  childWhenDragging: Icon(
                    Icons.sentiment_satisfied_alt,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
                Draggable<String>(
                  data: "sad",
                  feedback: Icon(
                    Icons.sentiment_dissatisfied,
                    color: Colors.red,
                    size: 50,
                  ),
                  child: Icon(
                    Icons.sentiment_dissatisfied,
                    color: Colors.red,
                    size: 50,
                  ),
                  childWhenDragging: Icon(
                    Icons.sentiment_dissatisfied,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                DragTarget<String>(
                  onAccept: (data) {
                    if (data == "happy") {
                      handleDrag("Q1");
                    }
                  },
                  builder: (context, candidateData, rejectedData) => Container(
                    color: draggedItem == "Q1" ? Colors.green[200] : Colors.grey[300],
                    child: Center(
                      child: Text("Q1", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                DragTarget<String>(
                  onAccept: (data) {
                    if (data == "happy") {
                      handleDrag("Q2");
                    }
                  },
                  builder: (context, candidateData, rejectedData) => Container(
                    color: draggedItem == "Q2" ? Colors.green[200] : Colors.grey[300],
                    child: Center(
                      child: Text("Q2", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                DragTarget<String>(
                  onAccept: (data) {
                    if (data == "sad") {
                      handleDrag("Q3");
                    }
                  },
                  builder: (context, candidateData, rejectedData) => Container(
                    color: draggedItem == "Q3" ? Colors.red[200] : Colors.grey[300],
                    child: Center(
                      child: Text("Q3", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                DragTarget<String>(
                  onAccept: (data) {
                    if (data == "sad") {
                      handleDrag("Q4");
                    }
                  },
                  builder: (context, candidateData, rejectedData) => Container(
                    color: draggedItem == "Q4" ? Colors.red[200] : Colors.grey[300],
                    child: Center(
                      child: Text("Q4", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
