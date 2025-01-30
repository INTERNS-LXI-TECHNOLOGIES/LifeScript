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

