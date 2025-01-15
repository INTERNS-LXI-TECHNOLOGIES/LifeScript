import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for PomodoroControllerApi
void main() {
  final instance = Openapi().getPomodoroControllerApi();

  group(PomodoroControllerApi, () {
    //Future<Pomodoro> getPomodoro(int id) async
    test('test getPomodoro', () async {
      // TODO
    });

    //Future<Pomodoro> setPomodoro(int workDuration, int breakDuration) async
    test('test setPomodoro', () async {
      // TODO
    });

  });
}
