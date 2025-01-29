import 'package:equatable/equatable.dart';

abstract class HabitTrackState extends Equatable {
  const HabitTrackState();

  @override
  List<Object> get props => [];
}

class HabitTrackInitial extends HabitTrackState {}

class HabitTrackLoading extends HabitTrackState {}

class HabitTrackSuccess extends HabitTrackState {}

class HabitTrackFailure extends HabitTrackState {
  final String error;

  const HabitTrackFailure({required this.error});

  @override
  List<Object> get props => [error];
}