part of 'set_pomodoro_bloc.dart';

abstract class SetPomodoroState extends Equatable {
  const SetPomodoroState();
  
  @override
  List<Object> get props => [];
  
  SetPomodoroState copyWith({int? breakDuration});
}

class SetPomodoroInitial extends SetPomodoroState {
  final int breakDuration;

  const SetPomodoroInitial({this.breakDuration = 5});

  @override
  SetPomodoroInitial copyWith({int? breakDuration}) {
    return SetPomodoroInitial(
      breakDuration: breakDuration ?? this.breakDuration,
    );
  }

  @override
  List<Object> get props => [breakDuration];
}
