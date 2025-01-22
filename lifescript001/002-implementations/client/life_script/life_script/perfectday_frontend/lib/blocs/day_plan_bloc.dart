import 'package:bloc/bloc.dart';
import 'package:openapiperfectday/openapi.dart';
import 'package:perfectday_frontend/events/day_plan_event.dart';
import 'package:perfectday_frontend/state/day_plan_state.dart';
import 'package:perfectday_frontend/state/day_plan_state.dart';

class DayPlanBloc extends Bloc<DayPlanEvent, DayPlanState> {
  final PerfectDayResourceApi _api; // OpenAPI client instance

  // Constructor that takes the OpenAPI client as a parameter
  DayPlanBloc(this._api) : super(DayPlanInitialState()) {
    // Handle CreateDayPlanEvent
    on<CreateDayPlanEvent>((event, emit) async {
      emit(DayPlanLoadingState()); // Emit loading state
      try {
        // Create a DayPlan object using the OpenAPI model
        final dayPlan = PerfectDay((b) => b
          ..title = event.title
          ..description = event.description);
        _api.createPerfectDay(perfectDay: dayPlan);
        final response = await _api.createPerfectDay(perfectDay: dayPlan);

        if (response.data != null) {
          // emit(DayPlanSuccessState(response.data?.title??'unknown'));
          print("succes");
        }
      } catch (e) {
        // Emit error state if the API call fails
        emit(DayPlanErrorState('Failed to create DayPlan: $e'));
      }
    });
  }
}
