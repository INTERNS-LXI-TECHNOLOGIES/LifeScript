import 'package:flutter/material.dart';
import 'task_adder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Input App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskAdder(), 
    );
  }
}