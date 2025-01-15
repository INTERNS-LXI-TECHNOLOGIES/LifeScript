import 'package:pomodoro_break/openapi/lib/src/api.dart';
import 'package:pomodoro_break/openapi/lib/src/api/pomodoro_controller_api.dart';

class PomodoroController{
    PomodoroControllerApi api = Openapi().getPomodoroControllerApi();

 void savePomo(int workDuration, int breakDuration) {
    api.setPomodoro(workDuration: workDuration, breakDuration: breakDuration);
  }

    void getPomo(id){
      api.getPomodoro(id: id);
    }
}