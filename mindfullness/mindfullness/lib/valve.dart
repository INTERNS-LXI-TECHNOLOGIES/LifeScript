import 'package:flutter/material.dart';
import 'dart:math';


class ValveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ValveUI(),
    );
  }
}

class ValveUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adjustable Valve UI"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              6, // Six valves
              (index) => AdjustableValve(index: index + 1),
            ),
          ),
        ),
      ),
    );
  }
}

class AdjustableValve extends StatefulWidget {
  final int index;
  const AdjustableValve({Key? key, required this.index}) : super(key: key);

  @override
  _AdjustableValveState createState() => _AdjustableValveState();
}

class _AdjustableValveState extends State<AdjustableValve> {
  double rotationAngle = 0; // Angle of rotation for the valve
  double value = 0; // Value (0 to 10) controlled by the slider

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Valve ${widget.index}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                rotationAngle += details.delta.dx * 0.01; // Adjust sensitivity
              });
            },
            child: Transform.rotate(
              angle: rotationAngle,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                  color: Colors.grey.shade200,
                ),
                child: Center(
                  child: Icon(
                    Icons.settings,
                    size: 50,
                    color: Colors.teal,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Angle: ${(rotationAngle * 180 / pi).toStringAsFixed(1)}°",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Value:", style: TextStyle(fontSize: 16)),
              const SizedBox(width: 10),
              Text(
                value.toStringAsFixed(1),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Slider(
            value: value,
            min: 0,
            max: 10,
            divisions: 10,
            activeColor: Colors.teal,
            inactiveColor: Colors.grey,
            label: value.toStringAsFixed(1),
            onChanged: (newValue) {
              setState(() {
                value = newValue;
              });
            },
          ),
        ],
      ),
    );
  }
}
