import 'package:equatable/equatable.dart';

abstract class DeletePageState extends Equatable {
  const DeletePageState();

  @override
  List<Object> get props => [];
}

class DeletePageInitial extends DeletePageState {}

class DeletePageLoading extends DeletePageState {}

class DeletePageSuccess extends DeletePageState {}

class DeletePageFailure extends DeletePageState {
  final String error;

  const DeletePageFailure(this.error);

  @override
  List<Object> get props => [error];
}
