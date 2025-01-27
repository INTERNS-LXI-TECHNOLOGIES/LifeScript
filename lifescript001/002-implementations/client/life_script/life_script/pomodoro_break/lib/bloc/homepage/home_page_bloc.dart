import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final void Function(String route) navigate;

  HomePageBloc({required this.navigate}) : super(HomePageInitial()) {
    on<NavigateToInfoPage>((event, emit) {
      print('Entered to InstructionPage with bloc installation...');
      navigate('/infoPage'); // Trigger navigation
    });

    on<NavigateToDeletePage>((event, emit) {
      print('Entered to deletePage with bloc installation...');
      navigate('/deletePage'); // Trigger navigation to delete page
    });

    on<PrintMessage>((event, emit) {
      print(event.message); // Handle print message
    });
  }
}
