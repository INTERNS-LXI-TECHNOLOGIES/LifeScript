import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapiperfectday/openapi.dart';
import 'package:perfectday_frontend/events/day_plan_event.dart';
import 'package:perfectday_frontend/state/day_plan_state.dart';
import 'package:perfectday_frontend/state/day_plan_succes_state.dart';

class DayPlanBloc extends Bloc<DayPlanEvent, DayPlanState> {
  final Openapi _api; // OpenAPI client instance

  DayPlanBloc(this._api) : super(DayPlanInitialState()) {
    // Create Day Plan Event
    on<CreateDayPlanEvent>((event, emit) async {
      emit(DayPlanLoadingState());
      try {
        final dayPlan = PerfectDay((b) => b
          ..title = event.title
          ..description = event.description
          ..date = event.date);

        final response = await _api.getPerfectDayResourceApi().createPerfectDay(
          perfectDay: dayPlan,
          headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
        );

        if (response.data != null) {
          print("Success");
        }
      } catch (e) {
        emit(DayPlanErrorState('Failed to create DayPlan: $e'));
      }
    });

    // Fetch DayPlans Event
    on<FetchDayPlansEvent>((event, emit) async {
      emit(DayPlanLoadingState());
      try {
        print("Fetching day plans...");
        print("JWT Token: ${Openapi.jwt}");

        final response =
            await _api.getPerfectDayResourceApi().getAllPerfectDays(
          headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
        );

        print("Raw API Response: ${response.data}");
        if (response.statusCode == 200 || response.statusCode == 201) {
          final List<PerfectDay> dayPlans =
              List<PerfectDay>.from(response.data!);

          emit(DayPlanFetchSuccessState(dayPlans));
        } else {
          emit(DayPlanErrorState("Failed to fetch day plans."));
        }
      } catch (e) {
        emit(DayPlanErrorState('Failed to fetch day plans: $e'));
      }
    });
    on<DeleteDayPlanEvent>((event, emit) async {
      emit(DayPlanLoadingState());
      try {
        print(event.dayPlanId);
        final response = await _api.getPerfectDayResourceApi().deletePerfectDay(
          id: event.dayPlanId,
          headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
        );

        if (response.statusCode == 200 || response.statusCode == 204) {
          print("Day plan deleted successfully");
          emit(DayPlanDeleteState("Day plan deleted successfully"));
        } else {
          emit(DayPlanErrorState("Failed to delete day plan."));
        }
      } catch (e) {
        emit(DayPlanErrorState("Failed to delete day plan: $e"));
      }
    });

    on<UpdateDayPlanEvent>((event, emit) async {
      emit(DayPlanLoadingState());
      try {
        final dayPlan = PerfectDay((b) => b
          ..title = event.title
          ..description = event.description
          ..date = event.date );

        final response = await _api.getPerfectDayResourceApi().updatePerfectDay(
          id: event.id,
          perfectDay: dayPlan,
          headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          emit(DayPlanFetchSuccessState([dayPlan])); // You can update with the new dayPlan here
          print("Successfully updated the day plan.");
        } else {
          emit(DayPlanErrorState("Failed to update the day plan."));
        }
      } catch (e) {
        emit(DayPlanErrorState('Failed to update the day plan: $e'));
      }
    });
  }
}
