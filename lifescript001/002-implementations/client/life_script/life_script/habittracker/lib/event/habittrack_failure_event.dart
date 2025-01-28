import 'package:habittracker/event/habit_track_event.dart';

class HabittrackFailureEvent extends HabitTrackEvent {
  final String errorMessage;

  HabittrackFailureEvent(this.errorMessage);
}
