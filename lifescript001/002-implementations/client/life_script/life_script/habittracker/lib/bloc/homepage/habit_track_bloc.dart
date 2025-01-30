import 'package:bloc/bloc.dart';
import 'package:habittracker_openapi/openapi.dart';
import 'habit_track_event.dart';
import 'habittrackstate.dart';
import 'package:habittracker_openapi/src/api.dart';

class HabitTrackBloc extends Bloc<HabitTrackEvent, HabitTrackState> {
  final Openapi openApi;

  HabitTrackBloc({required this.openApi}) : super(HabitTrackInitial());

  @override
  Stream<HabitTrackState> mapEventToState(HabitTrackEvent event) async* {
    if (event is HabitTrackSubmitted) {
      yield HabitTrackLoading();
      try {
        final habitTracker = HabitTrack((b) => b
          ..habitName = event.habitName
          ..description = event.description);
        
        final response = await openApi.getHabitTrackResourceApi().createHabitTrack(
          habitTrack: habitTracker,
          headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
        );

        if (response.statusCode == 200) {
          yield HabitTrackSuccess();
        } else {
          yield HabitTrackFailure(error: 'Failed to create habittrack');
        }
      } catch (e) {
        yield HabitTrackFailure(error: e.toString());
      }
    }
  }
}