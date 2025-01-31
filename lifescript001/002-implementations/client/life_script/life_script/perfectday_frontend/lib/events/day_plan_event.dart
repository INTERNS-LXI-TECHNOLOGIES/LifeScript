import 'package:openapiperfectday/openapi.dart';

abstract class DayPlanEvent {}

class CreateDayPlanEvent extends DayPlanEvent {
  final String title;
  final String description;
  final Date date;
  CreateDayPlanEvent({
    required this.title,
    required this.description,
    required this.date,
   });
}
class FetchDayPlansEvent extends DayPlanEvent {}

class DeleteDayPlanEvent extends DayPlanEvent {
  final int dayPlanId;

  DeleteDayPlanEvent(this.dayPlanId);
}

class UpdateDayPlanEvent extends DayPlanEvent {
  final int id;
  final String title;
  final String description;
  final Date date;

  UpdateDayPlanEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });
}
