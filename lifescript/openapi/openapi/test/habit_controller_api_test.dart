import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for HabitControllerApi
void main() {
  final instance = Openapi().getHabitControllerApi();

  group(HabitControllerApi, () {
    //Future<HabitEntity> createHabit(HabitEntity habitEntity) async
    test('test createHabit', () async {
      // TODO
    });

    //Future<BuiltList<HabitEntity>> getAllPersons() async
    test('test getAllPersons', () async {
      // TODO
    });

  });
}
