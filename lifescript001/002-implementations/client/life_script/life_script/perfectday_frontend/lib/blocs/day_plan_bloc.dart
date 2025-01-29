import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapiperfectday/openapi.dart';
import 'package:perfectday_frontend/events/day_plan_event.dart';
import 'package:perfectday_frontend/state/day_plan_state.dart';

class DayPlanBloc extends Bloc<DayPlanEvent, DayPlanState> {
  final Openapi _api; // OpenAPI client instance

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

        final response = await _api.getPerfectDayResourceApi().createPerfectDay(
          perfectDay: dayPlan,
          headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
        );

      
        if (response.data!= null) {
          print("Success");
        }
      } catch (e) {
        // Emit error state if the API call fails
        emit(DayPlanErrorState('Failed to create DayPlan: $e'));
      }
    });
  }
}
