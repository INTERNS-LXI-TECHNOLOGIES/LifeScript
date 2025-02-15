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
  {"id": 1, "task": "UI Design", "color": "#FFD700", "shape": "circle"},
  {"id": 2, "task": "Backend API", "color": "#32CD32", "shape": "square"},
  {"id": 3, "task": "Bug Fixing", "color": "#FF6347", "shape": "triangle"},
  {"id": 4, "task": "Testing", "color": "#1E90FF", "shape": "star"},
  {"id": 5, "task": "Reading Book", "color": "#8A2BE2", "shape": "book"}
]
''';

  List<Map<String, dynamic>> taskData = [];
  List<List<Map<String, dynamic>>> droppedTasks = [[], [], [], []];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    setState(() {
      taskData = List<Map<String, dynamic>>.from(jsonDecode(apiResponse));
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: taskData.map((task) {
                  return Draggable<Map<String, dynamic>>(
                    data: task,
                    feedback: _buildTask(task, true),
                    childWhenDragging: Opacity(opacity: 0.3, child: _buildTask(task, false)),
                    child: _buildTask(task, false),
                  );
                }).toList(),
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
                children: List.generate(4, (index) {
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
                                Text("Quadrant ${index + 1}",
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showResults,
        child: Icon(Icons.done),
      ),
    );
  }

 
void _showResults() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Task Summary"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(4, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Quadrant ${index + 1}: ${droppedTasks[index].length} tasks"),
                ...droppedTasks[index].map((task) {
                  return Text("- ${task['task']}");
                }).toList(),
                SizedBox(height: 8),
              ],
            );
          }),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}

  // Task Widget with Better UI
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