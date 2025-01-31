import 'package:flutter_bloc/flutter_bloc.dart';
import 'delete_page_event.dart';
import 'delete_page_state.dart';
import 'package:flutter/material.dart';
import 'package:openapiPomodoroBreak/openapi.dart';

class DeletePageBloc extends Bloc<DeletePageEvent, DeletePageState> {
  TextEditingController textController = TextEditingController();
  FocusNode textFieldFocusNode = FocusNode();
  final void Function(String route) navigate;

  DeletePageBloc({required this.navigate}) : super(DeletePageInitial()) {
    on<DeletePomodoroEvent>((event, emit) async {
      emit(DeletePageLoading());
      try {
        final response = await Openapi().getPomodoroBreakResourceApi().getPomodoroBreak(
          id: event.id,
          headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
        );

        if (response.data != null) {
          await Openapi().getPomodoroBreakResourceApi().deletePomodoroBreak(
            id: event.id,
            headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
          );
          emit(DeletePageSuccess(event.id));
          add(FetchPomodorosEvent());
        } else {
          emit(DeletePageFailure('Pomodoro ID ${event.id} does not exist'));
        }
      } catch (e) {
        emit(DeletePageFailure('Failed to delete Pomodoro ${event.id}'));
      }
    });

    on<NavigateToHomePage>((event, emit) {
      navigate('/home');
    });

    on<FetchPomodorosEvent>((event, emit) async {
      emit(DeletePageLoading());
      try {
        final response = await Openapi().getPomodoroBreakResourceApi().getAllPomodoroBreaksAsStream(
          headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
        );
        final pomodoros = response.data?.toList() ?? [];
        emit(DeletePageLoaded(pomodoros: pomodoros));
      } catch (e) {
        emit(DeletePageFailure('Failed to fetch Pomodoros'));
      }
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
    return super.close();
  }
}

class DeletePageSuccess extends DeletePageState {
  final int deletedId;

  const DeletePageSuccess(this.deletedId);

  @override
  List<Object> get props => [deletedId];
}
