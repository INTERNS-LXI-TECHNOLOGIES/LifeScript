import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for HabittrackResourceApi
void main() {
  final instance = Openapi().getHabittrackResourceApi();

  group(HabittrackResourceApi, () {
    //Future<Habittrack> createHabittrack(Habittrack habittrack) async
    test('test createHabittrack', () async {
      // TODO
    });

    //Future deleteHabittrack(int id) async
    test('test deleteHabittrack', () async {
      // TODO
    });

    //Future<BuiltList<Habittrack>> getAllHabittracksAsStream() async
    test('test getAllHabittracksAsStream', () async {
      // TODO
    });

    //Future<Habittrack> getHabittrack(int id) async
    test('test getHabittrack', () async {
      // TODO
    });

    //Future<Habittrack> partialUpdateHabittrack(int id, Habittrack habittrack) async
    test('test partialUpdateHabittrack', () async {
      // TODO
    });

    //Future<Habittrack> updateHabittrack(int id, Habittrack habittrack) async
    test('test updateHabittrack', () async {
      // TODO
    });

  });
}
