import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'set_pomodoro_model.dart';
export 'set_pomodoro_model.dart';

class SetPomodoroWidget extends StatefulWidget {
  const SetPomodoroWidget({super.key});

  @override
  State<SetPomodoroWidget> createState() => _SetPomodoroWidgetState();
}

class _SetPomodoroWidgetState extends State<SetPomodoroWidget> {
  late SetPomodoroModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SetPomodoroModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Set Pomodoro',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter Tight',
                  color: FlutterFlowTheme.of(context).info,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    color: Colors.transparent,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Work Duration',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Inter Tight',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '25 minutes',
                                  style: FlutterFlowTheme.of(context)
                                      .displaySmall
                                      .override(
                                        fontFamily: 'Inter Tight',
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Icon(
                                  Icons.lock,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24,
                                ),
                              ],
                            ),
                            Text(
                              'Work duration is fixed to maintain productivity rhythm',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ].divide(SizedBox(height: 16)),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Break Duration',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Inter Tight',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              '${_model.sliderValue?.toInt() ?? 5} minutes',
                              style: FlutterFlowTheme.of(context)
                                  .displaySmall
                                  .override(
                                    fontFamily: 'Inter Tight',
                                    color: FlutterFlowTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              'Adjust break time (5-15 minutes)',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Container(
                              width: 300,
                              child: Slider(
                                activeColor: FlutterFlowTheme.of(context).primary,
                                inactiveColor: Color(0xFFE0E3E7),
                                min: 5,
                                max: 15,
                                value: _model.sliderValue ??= 5,
                                onChanged: (newValue) {
                                  safeSetState(() {
                                    _model.sliderValue =
                                        double.parse(newValue.toStringAsFixed(4)); // Updates value
                                  });
                                },
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '5 min',
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Text(
                                  '15 min',
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ].divide(SizedBox(height: 16)),
                        ),
                      ),
                    ),
                  ),

                  Material(
                    color: Colors.transparent,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Break Time Tips',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Inter Tight',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              '• Take a short walk to refresh your mind',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              '• Do quick stretching exercises',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              '• Stay hydrated during breaks',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              '• Avoid screen time if possible',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ].divide(SizedBox(height: 16)),
                        ),
                      ),
                    ),
                  ),
FFButtonWidget(
  onPressed: () async {
// Get the work and break duration from the model (keeping the original logic)
    int workDuration = 25;
    int breakDuration = _model.sliderValue?.toInt() ?? 5;

    // Dummy data values for other fields
    int totalWorkingHour = 10;
    int dailyDurationOfWork = 7;
    int splitBreakDuration = 17;
    int completedBreaks = 2;
    String dateOfPomodoro = "2025-01-22T09:00:00Z";
    String timeOfPomodoroCreation = "2025-01-22T08:00:00Z";
    bool notificationForBreak = true;
    String finalMessage = "good job!";

    // Create the PomodoroBreak object with the dummy data and work/break duration from the slider
    PomodoroBreak pomodoroBreak = PomodoroBreak((b) => b
      ..totalWorkingHour = totalWorkingHour
      ..dailyDurationOfWork = dailyDurationOfWork
      ..splitBreakDuration = splitBreakDuration
      ..breakDuration = breakDuration  // Using the dynamic break duration
      ..completedBreaks = completedBreaks
      ..dateOfPomodoro = DateTime.parse(dateOfPomodoro).toUtc()
      ..timeOfPomodoroCreation = DateTime.parse(timeOfPomodoroCreation).toUtc()
      ..notificationForBreak = notificationForBreak
      ..finalMessage = finalMessage
    );


    try {
      // Pass the object to the API method
      await Openapi().getPomodoroBreakResourceApi().createPomodoroBreak(pomodoroBreak: pomodoroBreak);
      print('Pomodoro saved with work duration: $workDuration minutes and break duration: $breakDuration minutes');
    } on DioError catch (dioError) {
      print('Failed to save Pomodoro: ${dioError.message}');
      String errorMessage;
      if (dioError.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Connection timeout. Please check your network connection and try again.';
      } else if (dioError.type == DioErrorType.receiveTimeout) {
        errorMessage = 'Receive timeout. Please check your network connection and try again.';
      } else if (dioError.type == DioExceptionType.badResponse) {
        errorMessage = 'Server error: ${dioError.response?.statusCode}. Please try again later.';
      } else {
        errorMessage = 'Failed to save Pomodoro. Please check your network connection and try again.';
      }
      // Optionally, show a user-friendly error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      print('Unexpected error: $e');
      // Optionally, show a user-friendly error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred. Please try again.')),
      );
    }
  },
  text: 'Start Pomodoro',
  options: FFButtonOptions(
    width: MediaQuery.sizeOf(context).width,
    height: 56,
    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
    color: FlutterFlowTheme.of(context).primary,
    textStyle: FlutterFlowTheme.of(context).titleMedium.override(
      fontFamily: 'Inter Tight',
      color: FlutterFlowTheme.of(context).info,
      letterSpacing: 0.0,
    ),
    elevation: 3,
    borderRadius: BorderRadius.circular(28),
  ),
)

                ].divide(SizedBox(height: 32)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}