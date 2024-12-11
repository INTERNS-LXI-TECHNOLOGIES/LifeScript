import 'package:flutter/material.dart';



class TaskPrioritizationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskPrioritizationScreen(),
    );
  }
}

class TaskPrioritizationScreen extends StatefulWidget {
  @override
  _TaskPrioritizationScreenState createState() =>
      _TaskPrioritizationScreenState();
}

class _TaskPrioritizationScreenState extends State<TaskPrioritizationScreen> {
  String draggedTask = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Task Prioritization'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Drag tasks into the quadrants below',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Draggable<String>(
            data: 'Task A',
            child: TaskWidget(task: 'Task A'),
            feedback: TaskWidget(task: 'Task A', isDragging: true),
            childWhenDragging: TaskWidget(task: 'Task A', isDragging: false),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                QuadrantWidget(
                  title: 'Quadrant II',
                  color: Colors.green[100]!,
                  onAccept: (task) {
                    setState(() {
                      draggedTask = '$task added to Quadrant II';
                    });
                  },
                ),
                QuadrantWidget(
                  title: 'Quadrant III',
                  color: Colors.yellow[100]!,
                  onAccept: (task) {
                    setState(() {
                      draggedTask = '$task added to Quadrant III';
                    });
                  },
                ),
                QuadrantWidget(
                  title: 'Quadrant IV',
                  color: Colors.red[100]!,
                  onAccept: (task) {
                    setState(() {
                      draggedTask = '$task added to Quadrant IV';
                    });
                  },
                ),
              ],
            ),
          ),
          Text(
            draggedTask,
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class TaskWidget extends StatelessWidget {
  final String task;
  final bool isDragging;

  const TaskWidget({
    required this.task,
    this.isDragging = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDragging ? Colors.teal.withOpacity(0.5) : Colors.teal,
        boxShadow: isDragging
            ? []
            : [BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 2)],
      ),
      child: Text(
        task,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class QuadrantWidget extends StatelessWidget {
  final String title;
  final Color color;
  final void Function(String) onAccept;

  const QuadrantWidget({
    required this.title,
    required this.color,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAccept: onAccept,
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 100,
          height: 150,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: candidateData.isNotEmpty ? Colors.teal : Colors.transparent,
              width: 3,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
