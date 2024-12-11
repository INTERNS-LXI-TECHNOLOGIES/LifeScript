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
      home: MazeStartPage(),
    );
  }
}

class MazeStartPage extends StatefulWidget {
  @override
  _MazeStartPageState createState() => _MazeStartPageState();
}

class _MazeStartPageState extends State<MazeStartPage> {
  bool hasStarted = false;

  void startMaze() {
    setState(() {
      hasStarted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escape the Labyrinth of Procrastination'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Time Management Maze!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              child: hasStarted
                  ? Icon(
                      Icons.sentiment_satisfied_alt,
                      color: Colors.green,
                      size: 100,
                    )
                  : Icon(
                      Icons.sentiment_neutral,
                      color: Colors.grey,
                      size: 100,
                    ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                startMaze();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MazeGamePage()),
                );
              },
              child: Text('Start Maze'),
            ),
          ],
        ),
      ),
    );
  }
}

class MazeGamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Management Maze'),
      ),
      body: Center(
        child: Text(
          'Maze Game Goes Here!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
