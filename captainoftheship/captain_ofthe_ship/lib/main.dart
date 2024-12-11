import 'package:flutter/material.dart';

import 'animated_waves.dart';
import 'ship_wheel.dart';
import 'task.dart';
import 'task_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Task> tasks = [
    Task("Complete Report"),
    Task("Plan Vacation"),
    Task("Respond to Emails"),
    Task("Organize Desk"),
  ];

  Quadrant? draggedQuadrant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Life Compass")),
      body: Stack(
        children: [
          // Background Waves or Map
          Positioned.fill(child: AnimatedWaves()),
          
          // Ship's Wheel
          Center(child: ShipWheel(draggedQuadrant: draggedQuadrant)),

          // Draggable Task List
          Positioned(
            left: 20,
            top: 100,
            child: TaskList(
              tasks: tasks,
              onDrag: (task) {
                setState(() => draggedQuadrant = task.assignedQuadrant);
              },
            ),
          ),
        ],
      ),
    );
  }
}
