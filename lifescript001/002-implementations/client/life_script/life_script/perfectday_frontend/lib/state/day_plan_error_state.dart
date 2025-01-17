import 'package:perfectday_frontend/state/day_plan_state.dart';

class DayPlanError extends DayPlanState {
  final String message;

  DayPlanError(this.message);
}
