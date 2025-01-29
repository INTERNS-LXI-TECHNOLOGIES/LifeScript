
import 'package:habittracker/event/habit_event.dart';



class CreateHabitEvent extends HabitEvent {

  final String habitName;

  final String description;



  CreateHabitEvent(this.habitName, this.description);

}
