part of 'set_pomodoro_bloc.dart';

abstract class SetPomodoroEvent extends Equatable {
  const SetPomodoroEvent();

  @override
  List<Object> get props => [];
}

class UpdateBreakDuration extends SetPomodoroEvent {
  final int breakDuration;

  const UpdateBreakDuration(this.breakDuration);

  @override
  List<Object> get props => [breakDuration];
}

class CheckExistingPomodoro extends SetPomodoroEvent {}

class NavigateToInstructionPage extends SetPomodoroEvent {}
