import 'package:flutter/material.dart';
import 'dart:convert';
import 'task.dart';

class TaskAdder extends StatefulWidget {
  @override
  _TaskAdderPageState createState() => _TaskAdderPageState();
}

class _TaskAdderPageState extends State<TaskAdder> {
  final TextEditingController task1Controller = TextEditingController();
  final TextEditingController task2Controller = TextEditingController();
  final TextEditingController task3Controller = TextEditingController();
  final TextEditingController task4Controller = TextEditingController();

  List<Task> tasks = [];
  bool showTasks = false;

  void _submitTasks() {
    List<String> addedTasks = [];
    if (task1Controller.text.isNotEmpty) addedTasks.add('Task 1');
    if (task2Controller.text.isNotEmpty) addedTasks.add('Task 2');
    if (task3Controller.text.isNotEmpty) addedTasks.add('Task 3');
    if (task4Controller.text.isNotEmpty) addedTasks.add('Task 4');

    Task task = Task(
      task1: task1Controller.text,
      task2: task2Controller.text,
      task3: task3Controller.text,
      task4: task4Controller.text,
    );
    tasks.add(task);
    String jsonTasks = jsonEncode(task.toJson());
    print(jsonTasks);

    String message;
    if (addedTasks.length == 1) {
      message = '${addedTasks[0]} successfully added.';
    } else {
      message = '${addedTasks.length} tasks successfully added.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );

    task1Controller.clear();
    task2Controller.clear();
    task3Controller.clear();
    task4Controller.clear();
  }

  void _toggleShowTasks() {
    setState(() {
      showTasks = !showTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Input Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: task1Controller,
              decoration: InputDecoration(labelText: 'Task 1'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: task2Controller,
              decoration: InputDecoration(labelText: 'Task 2'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: task3Controller,
              decoration: InputDecoration(labelText: 'Task 3'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: task4Controller,
              decoration: InputDecoration(labelText: 'Task 4'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitTasks,
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleShowTasks,
              child: Text(showTasks ? 'Hide Tasks' : 'Show Tasks'),
            ),
            SizedBox(height: 20),
            if (showTasks)
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    Task task = tasks[index];
                    List<String> nonEmptyTasks = [];
                    if (task.task1.isNotEmpty) nonEmptyTasks.add('Task 1: ${task.task1}');
                    if (task.task2.isNotEmpty) nonEmptyTasks.add('Task 2: ${task.task2}');
                    if (task.task3.isNotEmpty) nonEmptyTasks.add('Task 3: ${task.task3}');
                    if (task.task4.isNotEmpty) nonEmptyTasks.add('Task 4: ${task.task4}');
                    return nonEmptyTasks.isNotEmpty
                        ? ListTile(
                            title: Text('Task ${index + 1}'),
                            subtitle: Text(nonEmptyTasks.join(', ')),
                          )
                        : Container();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    task1Controller.dispose();
    task2Controller.dispose();
    task3Controller.dispose();
    task4Controller.dispose();
    super.dispose();
  }
}
