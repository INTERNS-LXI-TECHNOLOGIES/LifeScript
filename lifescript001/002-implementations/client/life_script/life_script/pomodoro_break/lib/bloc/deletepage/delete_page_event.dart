import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DeletePageEvent extends Equatable {
  const DeletePageEvent();

  @override
  List<Object> get props => [];
}

class DeletePomodoroEvent extends DeletePageEvent {}

class NavigateToHomePage extends DeletePageEvent{}
