import 'package:openapiperfectday/openapi.dart';
import 'package:perfectday_frontend/state/day_plan_state.dart';

class DayPlanSuccessState extends DayPlanState {
 // final String title;
  final List<PerfectDay> dayPlans;

  DayPlanSuccessState(this.dayPlans);

 
}

class DayPlanDeleteState  extends DayPlanState{
  String message;

  DayPlanDeleteState(this.message);
}