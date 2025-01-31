import 'package:openapiperfectday/openapi.dart';

abstract class DayPlanState {
  get authorities => null;
}

class DayPlanInitialState extends DayPlanState {}

class DayPlanLoadingState extends DayPlanState {}

class DayPlanSuccessState extends DayPlanState {
  final String title;
  final String description;
  final Date date;

  DayPlanSuccessState(String s, {required this.title, required this.description, required this.date});
}

class DayPlanErrorState extends DayPlanState {
  final String errorMessage;

  DayPlanErrorState(this.errorMessage);
}

class DayPlanFetchSuccessState extends DayPlanState {
  final List<PerfectDay> dayPlans;

  DayPlanFetchSuccessState(this.dayPlans);
}
