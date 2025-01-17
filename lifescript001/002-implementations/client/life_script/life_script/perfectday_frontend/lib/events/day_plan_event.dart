abstract class DayPlanEvent {}

class CreateDayPlanEvent extends DayPlanEvent {
  final String title;
  final String description;

  CreateDayPlanEvent({required this.title, required this.description});
}

/*class UpdateDayPlanEvent extends DayPlanEvent {
  final String title;
  final String description;

  UpdateDayPlanEvent({required this.title, required this.description});
}*/
