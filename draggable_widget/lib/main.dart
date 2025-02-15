import 'dart:convert';
import 'package:draggable_screen/shape_painter.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: DragDropScreen(),
    );
  }
}

class DragDropScreen extends StatefulWidget {
  @override
  _DragDropScreenState createState() => _DragDropScreenState();
}

class _DragDropScreenState extends State<DragDropScreen> {
  String apiResponse = '''
[
  { "id": 1, "task": "Morning Jog", "color": "#FFD700", "shape": "running" },
  { "id": 2, "task": "Meditation Session", "color": "#32CD32", "shape": "yoga" },
  { "id": 3, "task": "Brainstorming Ideas", "color": "#FF6347", "shape": "brain" },
  { "id": 4, "task": "Deep Breathing Exercise", "color": "#1E90FF", "shape": "breathing" },
  { "id": 5, "task": "Coding Session", "color": "#8A2BE2", "shape": "computer" },
  { "id": 6, "task": "Book Reading", "color": "#FF4500", "shape": "book" },
  { "id": 7, "task": "Testing Features", "color": "#008080", "shape": "star" },
  { "id": 8, "task": "Drawing and Design", "color": "#800080", "shape": "triangle" },
  { "id": 9, "task": "UI Layout Fix", "color": "#4682B4", "shape": "square" },
  { "id": 10, "task": "Research on AI", "color": "#DC143C", "shape": "circle" },
  { "id": 11, "task": "Backend API Development", "color": "#2E8B57", "shape": "hormones" }
]
''';

  String quadrantsResponse = '''
[
  { "id": 1, "name": "Quadrant 1", "icon": "hourglass_empty_rounded" },
  { "id": 2, "name": "Quadrant 2", "icon": "hourglass_empty_rounded" },
  { "id": 3, "name": "Quadrant 3", "icon": "hourglass_empty_rounded" },
  { "id": 4, "name": "Quadrant 4", "icon": "hourglass_empty_rounded" }
]
''';

  List<Map<String, dynamic>> taskData = [];
  List<Map<String, dynamic>> quadrantsData = [];
  List<List<Map<String, dynamic>>> droppedTasks = [[], [], [], []];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    setState(() {
      taskData = List<Map<String, dynamic>>.from(jsonDecode(apiResponse));
      quadrantsData = List<Map<String, dynamic>>.from(jsonDecode(quadrantsResponse));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text("Drag your Tasks",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        children: [
          // Draggable Task List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: taskData.sublist(0, (taskData.length / 2).ceil()).map((task) {
                        return Expanded(
                          child: Draggable<Map<String, dynamic>>(
                            data: task,
                            feedback: _buildTask(task, true),
                            childWhenDragging: Opacity(opacity: 0.3, child: _buildTask(task, false)),
                            child: _buildTask(task, false),
                          ),
                        );
                      }).toList(),
                    ),
                    Row(
                      children: taskData.sublist((taskData.length / 2).ceil()).map((task) {
                        return Expanded(
                          child: Draggable<Map<String, dynamic>>(
                            data: task,
                            feedback: _buildTask(task, true),
                            childWhenDragging: Opacity(opacity: 0.3, child: _buildTask(task, false)),
                            child: _buildTask(task, false),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          // Quadrants (Drag Targets)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: List.generate(quadrantsData.length, (index) {
                  return DragTarget<Map<String, dynamic>>(
                    onAccept: (task) {
                      setState(() {
                        droppedTasks[index].add(task);
                        taskData.remove(task);
                      });
                    },
                    builder: (context, candidateData, rejectedData) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.hourglass_empty_rounded, color: Colors.orange, size: 28),
                                SizedBox(height: 4),
                                Text(quadrantsData[index]['name'],
                                    style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold)),
                                SizedBox(height: 6),
                                Text(
                                  "Tasks: ${droppedTasks[index].length}",
                                  style: TextStyle(color: Colors.black54, fontSize: 14),
                                ),
                                SizedBox(height: 6),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: droppedTasks[index].map((task) {
                                        return Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Draggable<Map<String, dynamic>>(
                                              data: task,
                                              feedback: _buildTask(task, true, sizeFactor: 0.9),
                                              childWhenDragging: Opacity(opacity: 0.3, child: _buildTask(task, false, sizeFactor: 0.9)),
                                              child: _buildTask(task, false, sizeFactor: 1.0),
                                            ),
                                            Positioned(
                                              top: -3,
                                              right: -3,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    droppedTasks[index].remove(task);
                                                    taskData.add(task);
                                                  });
                                                },
                                                child: Icon(Icons.cancel, color: Colors.red, size: 18),
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showResults,
        label: Text("Show Results"),
        icon: Icon(Icons.done),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showResults() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Task Summary",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(quadrantsData.length, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${quadrantsData[index]['name']}: ${droppedTasks[index].length} tasks",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                    ),
                    ...droppedTasks[index].map((task) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          children: [
                            CustomPaint(
                              size: Size(16, 16),
                              painter: ShapePainter(shape: task['shape'], color: _hexToColor(task['color'])),
                            ),
                            SizedBox(width: 8),
                            Text(
                              task['task'],
                              style: TextStyle(fontSize: 16, color: Colors.black87),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    SizedBox(height: 12),
                  ],
                );
              }),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
                style: TextStyle(fontSize: 16, color: Colors.orange),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTask(Map<String, dynamic> task, bool isDragging, {double sizeFactor = 1.0}) {
    return Transform.scale(
      scale: sizeFactor,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            if (!isDragging) BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, spreadRadius: 1),
          ],
        ),
        child: Row(
          children: [
            CustomPaint(
              size: Size(24, 24),
              painter: ShapePainter(shape: task['shape'], color: _hexToColor(task['color'])),
            ),
            SizedBox(width: 5),
            Text(
              task['task'],
              style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Function for HEX Colors
  Color _hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }
}