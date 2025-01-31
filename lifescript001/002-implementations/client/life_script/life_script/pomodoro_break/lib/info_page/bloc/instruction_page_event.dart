part of 'instruction_page_bloc.dart';

abstract class InstructionPageEvent extends Equatable {
  const InstructionPageEvent();

  @override
  List<Object> get props => [];
}

class NavigateToHomePage extends InstructionPageEvent {}

class NavigateToSetPomodoroPage extends InstructionPageEvent {}
