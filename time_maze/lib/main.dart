import 'package:flutter/material.dart';
import 'GraphManager.dart';
import 'SmileManager.dart';
import 'QuadrantWidget.dart';
import 'GraphWidget.dart';
import 'DragTargetWidget.dart';

void main() => runApp(QuadrantDragApp());

class QuadrantDragApp extends StatefulWidget {
  @override
  _QuadrantDragAppState createState() => _QuadrantDragAppState();
}

class _QuadrantDragAppState extends State<QuadrantDragApp> {
  final GraphManager graphManager = GraphManager();
  final SmileManager smileManager = SmileManager();

  void onQuadrantDropped(String quadrant) {
    setState(() {
      graphManager.updateGraphData(quadrant);
      smileManager.updateSmileState(quadrant);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quadrant Dragging with Graph'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            // Smile Display
            Text(
              smileManager.getSmileEmoji(),
              style: TextStyle(fontSize: 60),
            ),
            SizedBox(height: 10),
            // Motivational Quote
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                smileManager.getQuote(),
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            // Quadrant Widgets
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                QuadrantWidget(label: 'Q1', color: Colors.green),
                QuadrantWidget(label: 'Q2', color: Colors.blue),
                QuadrantWidget(label: 'Q3', color: Colors.orange),
                QuadrantWidget(label: 'Q4', color: Colors.red),
              ],
            ),
            SizedBox(height: 30),
            // Drag Target
            DragTargetWidget(onQuadrantDropped: onQuadrantDropped),
            SizedBox(height: 30),
            // Graph Display
            Expanded(
              child: GraphWidget(graphManager: graphManager),
            ),
          ],
        ),
      ),
    );
  }
}
