import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'instruction_page_event.dart';
part 'instruction_page_state.dart';

class InstructionPageBloc extends Bloc<InstructionPageEvent, InstructionPageState> {
  final void Function(String route) navigate;

  InstructionPageBloc({required this.navigate}) : super(InstructionPageInitial()) {
    on<NavigateToHomePage>((event, emit) {
      print('Back to Home page via Bloc');
      navigate('/Home');
    });

    on<NavigateToSetPomodoroPage>((event, emit) {
      print('Entering to PomodoroSet page via Bloc');
      navigate('/setPomodoro');
    });
  }
}
