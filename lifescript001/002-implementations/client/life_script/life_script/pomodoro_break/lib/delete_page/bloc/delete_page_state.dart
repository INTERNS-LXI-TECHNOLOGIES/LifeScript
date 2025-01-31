import 'package:equatable/equatable.dart';
import 'package:openapiPomodoroBreak/openapi.dart';

abstract class DeletePageState extends Equatable {
  const DeletePageState();

  @override
  List<Object> get props => [];
}

class DeletePageInitial extends DeletePageState {}

class DeletePageLoading extends DeletePageState {}

class DeletePageFailure extends DeletePageState {
  final String error;

  const DeletePageFailure(this.error);

  @override
  List<Object> get props => [error];
}

class DeletePageLoaded extends DeletePageState {
  final List<PomodoroBreak> pomodoros;

  const DeletePageLoaded({required this.pomodoros});

  @override
  List<Object> get props => [pomodoros];
}
