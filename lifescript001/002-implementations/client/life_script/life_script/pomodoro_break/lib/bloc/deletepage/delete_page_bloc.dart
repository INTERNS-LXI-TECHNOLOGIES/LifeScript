import 'package:flutter_bloc/flutter_bloc.dart';
import 'delete_page_event.dart';
import 'delete_page_state.dart';
import 'package:flutter/material.dart';

class DeletePageBloc extends Bloc<DeletePageEvent, DeletePageState> {
  TextEditingController textController = TextEditingController();
  FocusNode textFieldFocusNode = FocusNode();
  final void Function(String route) navigate;

  DeletePageBloc({required this.navigate}) : super(DeletePageInitial()) {
    on<DeletePomodoroEvent>((event, emit) async {
      emit(DeletePageLoading());
      try {
        // Simulate a delete operation
        await Future.delayed(Duration(seconds: 2));
        emit(DeletePageSuccess());
      } catch (e) {
        emit(DeletePageFailure(e.toString()));
      }
    });

    on<NavigateToHomePage>((event, emit) {
      print('Back to HomePage with bloc installation...');
      navigate('/home'); // Trigger navigation using GoRouter
    });
  }

  String? textControllerValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Pomodoro ID';
    }
    return null;
  }

  @override
  Future<void> close() {
    textController.dispose();
    textFieldFocusNode.dispose();
    return super.close();
  }
}
