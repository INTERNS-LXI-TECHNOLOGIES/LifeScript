abstract class DayPlanEvent {}

class CreateDayPlanEvent extends DayPlanEvent {
  final String title;
  final String description;
  final DateTime date;
  CreateDayPlanEvent({
    required this.title,
    required this.description,
    required this.date});
}

/*class UpdateDayPlanEvent extends DayPlanEvent {
  final String title;
  final String description;

  UpdateDayPlanEvent({required this.title, required this.description});
}*/
