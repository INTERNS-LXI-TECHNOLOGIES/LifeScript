import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DeletePageEvent extends Equatable {
  const DeletePageEvent();

  @override
  List<Object> get props => [];
}

class DeletePomodoroEvent extends DeletePageEvent {
  final int id;

  const DeletePomodoroEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class NavigateToHomePage extends DeletePageEvent {}

class FetchPomodorosEvent extends DeletePageEvent {}
