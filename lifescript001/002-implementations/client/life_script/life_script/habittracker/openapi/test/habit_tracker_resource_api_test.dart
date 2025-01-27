import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for HabitTrackerResourceApi
void main() {
  final instance = Openapi().getHabitTrackerResourceApi();

  group(HabitTrackerResourceApi, () {
    //Future<HabitTracker> createHabitTracker(HabitTracker habitTracker) async
    test('test createHabitTracker', () async {
      // TODO
    });

    //Future deleteHabitTracker(int id) async
    test('test deleteHabitTracker', () async {
      // TODO
    });

    //Future<BuiltList<HabitTracker>> getAllHabitTrackersAsStream() async
    test('test getAllHabitTrackersAsStream', () async {
      // TODO
    });

    //Future<HabitTracker> getHabitTracker(int id) async
    test('test getHabitTracker', () async {
      // TODO
    });

    //Future<HabitTracker> partialUpdateHabitTracker(int id, HabitTracker habitTracker) async
    test('test partialUpdateHabitTracker', () async {
      // TODO
    });

    //Future<HabitTracker> updateHabitTracker(int id, HabitTracker habitTracker) async
    test('test updateHabitTracker', () async {
      // TODO
    });

  });
}
