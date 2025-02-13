class Task {
  String task1;
  String task2;
  String task3;
  String task4;

  Task({required this.task1, required this.task2, required this.task3, required this.task4}) {
    print('Received the JSON on Task class');
  }

  Map<String, String> toJson() {
    return {
      'task1': task1,
      'task2': task2,
      'task3': task3,
      'task4': task4,
    };
  }
}
