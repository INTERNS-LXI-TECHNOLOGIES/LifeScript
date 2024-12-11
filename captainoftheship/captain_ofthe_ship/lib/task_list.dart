import 'package:flutter/material.dart';

import 'task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task) onDrag;

  TaskList({required this.tasks, required this.onDrag});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: tasks.map((task) {
        return Draggable<Task>(
          data: task,
          feedback: Material(
            child: Card(
              color: Colors.blue,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(task.title, style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          childWhenDragging: Container(),
          child: Card(
            child: ListTile(
              title: Text(task.title),
            ),
          ),
        );
      }).toList(),
    );
  }
}
