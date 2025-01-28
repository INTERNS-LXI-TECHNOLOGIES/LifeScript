import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habittracker/event/create_habit_event.dart';
import 'package:habittracker/event/habit_event.dart';
import 'package:habittracker/state/habit_Initial_state.dart';
import 'package:habittracker/state/habit_failure_state.dart';
import 'package:habittracker/state/habit_success_state.dart';
import 'package:habittracker/state/habit_track_state.dart';
import 'package:habittracker_openapi/openapi.dart';

class HabitTrackBloc extends Bloc<HabitEvent , HabitTrackState>{

HabitTrackState _state = HabitInitialState();
 
HabitTrackState get state => _state;

HabitTrackBloc(super.initialState);


void onEvent (HabitEvent event){
  if(event is CreateHabitEvent){
   _createHabittrack(event as CreateHabitEvent);
  }
  emit(_state);
}

 
Future<void> _createHabittrack(CreateHabitEvent event) async {
    try {
      _state = HabitInitialState();
      // Trigger UI update by calling setState
      // For example, use a callback or `setState()` in a StatefulWidget
      // Example: setState(() => _state = HabittrackCreatingState());

      final Openapi openApi = Openapi();
      final habitName = event.habitName;
      final description = event.description;

      if (habitName.isEmpty || description.isEmpty) {
        _state = HabitFailureState('Habit name and description cannot be empty');
        return;
      }

      final habitTracker = Habittrack((b) => b
        ..habitName = habitName
        ..description = description);

      final response = await openApi.getHabittrackResourceApi().createHabittrack(
        habittrack: habitTracker,
        headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
      );

      if (response.statusCode == 200) {
        _state = HabitSuccessState();
      } else {
        _state = HabitFailureState('Failed to create habittrack');
      }
    } catch (e) {
      _state = HabitFailureState('Error creating habittrack: $e');
    }
}
}