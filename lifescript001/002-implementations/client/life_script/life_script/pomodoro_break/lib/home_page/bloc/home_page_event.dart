part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class NavigateToInfoPage extends HomePageEvent {}

class NavigateToDeletePage extends HomePageEvent {}

class PrintMessage extends HomePageEvent {
  final String message;

  const PrintMessage(this.message);

  @override
  List<Object> get props => [message];
}
