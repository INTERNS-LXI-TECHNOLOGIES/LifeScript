import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'set_pomodoro_event.dart';
part 'set_pomodoro_state.dart';

class SetPomodoroBloc extends Bloc<SetPomodoroEvent, SetPomodoroState> {
  SetPomodoroBloc() : super(SetPomodoroInitial()) {
    on<UpdateBreakDuration>((event, emit) {
      emit(state.copyWith(breakDuration: event.breakDuration));
    });
  }
}
