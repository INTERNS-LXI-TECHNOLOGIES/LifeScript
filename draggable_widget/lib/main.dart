import 'dart:convert';
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
    {"id": 1, "task": "UI Design", "color": "#FFD700"},
    {"id": 2, "task": "Backend API", "color": "#32CD32"},
    {"id": 3, "task": "Bug Fixing", "color": "#FF6347"},
    {"id": 4, "task": "Testing", "color": "#1E90FF"}
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
          gradient: LinearGradient(
            colors: [_hexToColor(task['color']).withOpacity(0.9), Colors.white.withOpacity(0.6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            if (!isDragging) BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, spreadRadius: 1),
          ],
        ),
        child: Text(
          task['task'],
          style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold),
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
