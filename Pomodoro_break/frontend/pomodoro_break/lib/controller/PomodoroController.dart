import 'package:openapi/openapi.dart';

class PomodoroController{
    PomodoroControllerApi api = Openapi().getPomodoroControllerApi();

 void savePomo(int workDuration, int breakDuration) {
    api.setPomodoro(workDuration: workDuration, breakDuration: breakDuration);
  }

    void getPomo(id){
      api.getPomodoro(id: id);
    }
}