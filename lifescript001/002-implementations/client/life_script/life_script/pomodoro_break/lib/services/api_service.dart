import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    // Set base URL
    _dio.options.baseUrl = 'http://localhost:8080';

    // Set common headers
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImV4cCI6MTczNzc3NzUyMywiYXV0aCI6IlJPTEVfQURNSU4gUk9MRV9VU0VSIiwiaWF0IjoxNzM3NjkxMTIzfQ.XeLivF6dRZ_wiR1DYA8GAmHr01ZmChuKuuom3A0p7wKcQHe81khquke9cNDbZCXJxiYwhwRXQa5mx1lB8jjqiQ',
    };
  }

  Future<void> createPomodoro({
    required int workDuration,
    required int breakDuration,
    required int totalWorkingHour,
    required int dailyDurationOfWork,
    required int splitBreakDuration,
    required int completedBreaks,
    required String dateOfPomodoro,
    required String timeOfPomodoroCreation,
    required bool notificationForBreak,
    required String finalMessage,
  }) async {
    try {
      // Create the request payload
      Map<String, dynamic> pomodoroData = {
        "totalWorkingHour": totalWorkingHour,
        "dailyDurationOfWork": dailyDurationOfWork,
        "splitBreakDuration": splitBreakDuration,
        "breakDuration": breakDuration,
        "completedBreaks": completedBreaks,
        "dateOfPomodoro": dateOfPomodoro,
        "timeOfPomodoroCreation": timeOfPomodoroCreation,
        "notificationForBreak": notificationForBreak,
        "finalMessage": finalMessage,
      };

      // Log request payload
      print('Request payload: $pomodoroData');

      // Make the POST request
      Response response = await _dio.post('/api/pomodoro-breaks', data: pomodoroData);
      print('Pomodoro created successfully: ${response.data}');
    } on DioError catch (e) {
      print('Failed to create Pomodoro: ${e.response?.data}');
      print('Error details: ${e.toString()}');
      throw e;
    }
  }
}
