import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HabitListScreen extends StatefulWidget {
  const HabitListScreen({Key? key}) : super(key: key);

  @override
  _HabitListScreenState createState() => _HabitListScreenState();
}

class _HabitListScreenState extends State<HabitListScreen> {
  List<Habit> habits = [];
  String newHabit = '';
  int duration = 0;

  @override
  void initState() {
    super.initState();
    fetchHabits();
  }

  Future<void> fetchHabits() async {
    final response = await http.get(Uri.parse('http://localhost:8080/api/habits'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        habits = data.map((item) => Habit.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load habits');
    }
  }

  Future<void> createHabit() async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/habits'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': newHabit,
        'duration': duration,
      }),
    );

    if (response.statusCode == 200) {
      fetchHabits();
    } else {
      throw Exception('Failed to create habit');
    }
  }

  Future<void> markTaskCompleted(int taskId) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/habits/tasks/$taskId/complete'),
    );

    if (response.statusCode == 200) {
      fetchHabits();
    } else {
      throw Exception('Failed to mark task as completed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Enter Habit'),
              onChanged: (value) {
                setState(() {
                  newHabit = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Duration in Days'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  duration = int.tryParse(value) ?? 0;
                });
              },
            ),
            ElevatedButton(
              onPressed: createHabit,
              child: const Text('Add Habit'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Habits',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  return HabitItem(
                    habit: habit,
                    onTaskCompleted: markTaskCompleted,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HabitItem extends StatelessWidget {
  final Habit habit;
  final Future<void> Function(int taskId) onTaskCompleted;

  const HabitItem({Key? key, required this.habit, required this.onTaskCompleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              habit.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Duration: ${habit.duration} days'),
            const SizedBox(height: 10),
            const Text(
              'Tasks:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ...habit.tasks.map((task) => TaskItem(task: task, onTaskCompleted: onTaskCompleted)),
          ],
        ),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;
  final Future<void> Function(int taskId) onTaskCompleted;

  const TaskItem({Key? key, required this.task, required this.onTaskCompleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.description),
      subtitle: Text(task.completed ? 'Completed' : 'Pending'),
      trailing: task.completed
          ? null
          : IconButton(
              icon: const Icon(Icons.check),
              onPressed: () => onTaskCompleted(task.id),
            ),
    );
  }
}

class Habit {
  final int id;
  final String name;
  final int duration;
  final List<Task> tasks;

  Habit({
    required this.id,
    required this.name,
    required this.duration,
    required this.tasks,
  });

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'],
      name: json['name'],
      duration: json['duration'],
      tasks: (json['tasks'] as List)
          .map((taskJson) => Task.fromJson(taskJson))
          .toList(),
    );
  }
}

class Task {
  final int id;
  final String description;
  final bool completed;

  Task({
    required this.id,
    required this.description,
    required this.completed,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      description: json['description'],
      completed: json['completed'],
    );
  }
}