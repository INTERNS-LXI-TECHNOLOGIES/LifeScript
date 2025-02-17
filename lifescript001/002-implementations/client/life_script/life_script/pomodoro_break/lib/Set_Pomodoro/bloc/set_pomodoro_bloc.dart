import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:openapiPomodoroBreak/openapi.dart';

part 'set_pomodoro_event.dart';
part 'set_pomodoro_state.dart';

class SetPomodoroBloc extends Bloc<SetPomodoroEvent, SetPomodoroState> {
  final void Function(String route) navigate;

  SetPomodoroBloc({required this.navigate}) : super(SetPomodoroInitial()) {
    on<UpdateBreakDuration>((event, emit) {
      emit(state.copyWith(breakDuration: event.breakDuration));
    });

    on<CheckExistingPomodoro>((event, emit) async {
      final existingPomodoro = await _checkIfPomodoroExists();
      if (existingPomodoro) {
        emit(PomodoroExists());
      } else {
        emit(SetPomodoroInitial());
      }
    });

    on<NavigateToInstructionPage>((event, emit) {
      navigate('/infopage');
    });

    on<NavigateToHomePage>((event, emit) {
      navigate('/finalView');
    });
  }

  Future<bool> _checkIfPomodoroExists() async {
    try {
      final jwtToken = Openapi.jwt;
      if (jwtToken == null || jwtToken.isEmpty) {
        throw DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 401,
            statusMessage: 'Unauthorized',
          ),
        );
      }

      final response = await Openapi().getPomodoroBreakResourceApi().getAllPomodoroBreaksAsStream(
        headers: {'Authorization': 'Bearer $jwtToken'},
      );
      final pomodoros = response.data?.toList() ?? [];
      final currentDate = DateTime.now().toUtc().toIso8601String().split('T').first;

      return pomodoros.any((pomodoro) => pomodoro.dateOfPomodoro?.toIso8601String().split('T').first == currentDate);
    } catch (e) {
      return false;
    }
  }
}
