abstract class DayPlanState {}

class DayPlanInitialState extends DayPlanState {}

class DayPlanLoadingState extends DayPlanState {}

class DayPlanSuccessState extends DayPlanState {
  final String title;
  final String description;

  DayPlanSuccessState(String s, {required this.title, required this.description});
}

class DayPlanErrorState extends DayPlanState {
  final String errorMessage;

  DayPlanErrorState(this.errorMessage);
}
