import 'package:flutter/material.dart';
import 'dart:math'; // Import for sin and cos functions

class PizzaProgressTracker extends StatefulWidget {
  final int totalPomodoros; // Total number of Pomodoros for the day
  const PizzaProgressTracker({Key? key, required this.totalPomodoros}) : super(key: key);

  @override
  _PizzaProgressTrackerState createState() => _PizzaProgressTrackerState();
}

class _PizzaProgressTrackerState extends State<PizzaProgressTracker> {
  late int remainingPomodoros;
  late List<bool> toppingsStatus;

  @override
  void initState() {
    super.initState();
    remainingPomodoros = widget.totalPomodoros;
    toppingsStatus = List<bool>.filled(widget.totalPomodoros, true); // All toppings are visible initially
  }

  void completePomodoro(int index) {
    if (remainingPomodoros > 0 && toppingsStatus[index]) {
      setState(() {
        toppingsStatus[index] = false; // Remove the topping
        remainingPomodoros--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza Progress Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Remaining Pomodoros: $remainingPomodoros',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/pizza_base.png', // Pizza base image
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                ...List.generate(widget.totalPomodoros, (index) {
                  final double angle = (360 / widget.totalPomodoros) * index; // Position toppings around the pizza
                  final double radians = angle * (pi / 180); // Convert to radians
                  return toppingsStatus[index]
                      ? Positioned(
                          left: 150 + 100 * cos(radians) - 15, // Adjust X position
                          top: 150 + 100 * sin(radians) - 15, // Adjust Y position
                          child: GestureDetector(
                            onTap: () => completePomodoro(index),
                            child: Image.asset(
                              'assets/topping.png', // Replace with your topping image
                              width: 30,
                              height: 30,
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                }),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: remainingPomodoros == 0
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Congratulations! All tasks completed!')),
                      );
                    }
                  : null,
              child: const Text('Complete Day'),
            ),
          ],
        ),
      ),
    );
  }
}


void main() {
  runApp(const MaterialApp(
    home: PizzaProgressTracker(totalPomodoros: 8),
  ));
}
