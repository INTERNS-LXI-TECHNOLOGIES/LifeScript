import 'package:equatable/equatable.dart';

abstract class HabitTrackEvent extends Equatable {
  const HabitTrackEvent();

  @override
  List<Object> get props => [];
}

class HabitTrackSubmitted extends HabitTrackEvent {
  final String habitName;
  final String description;

  const HabitTrackSubmitted({required this.habitName, required this.description});

  @override
  List<Object> get props => [habitName, description];
}