import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for HabitControllerApi
void main() {
  final instance = Openapi().getHabitControllerApi();

  group(HabitControllerApi, () {
    //Future<BuiltList<Task>> getTaskForAllHabits() async
    test('test getTaskForAllHabits', () async {
      // TODO
    });

    //Future<BuiltList<Task>> markTaskCompleted(int taskId) async
    test('test markTaskCompleted', () async {
      // TODO
    });

    //Future<BuiltList<HabitEntity>> readAllHabits() async
    test('test readAllHabits', () async {
      // TODO
    });

    //Future<HabitEntity> saveHabit(HabitEntity habitEntity) async
    test('test saveHabit', () async {
      // TODO
    });

  });
}
