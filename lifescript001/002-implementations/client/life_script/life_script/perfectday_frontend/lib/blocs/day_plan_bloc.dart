import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapiperfectday/openapi.dart';
import 'package:perfectday_frontend/events/day_plan_event.dart';
import 'package:perfectday_frontend/state/day_plan_state.dart';

class DayPlanBloc extends Bloc<DayPlanEvent, DayPlanState> {
  final Openapi _api; // OpenAPI client instance

  
                                DayPlanBloc(this._api) : super(DayPlanInitialState()) {
    
                                on<CreateDayPlanEvent>((event, emit) async {
                                emit(DayPlanLoadingState()); // Emit loading state
                               try {
      
                             final dayPlan = PerfectDay((b) => b
                          ..title = event.title
                         ..description = event.description
                       ..date = event.date);

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
    }
  );
 }
}
