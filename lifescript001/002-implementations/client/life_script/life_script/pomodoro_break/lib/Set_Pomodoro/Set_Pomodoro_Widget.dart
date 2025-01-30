import 'package:dio/dio.dart';
import 'package:openapiPomodoroBreak/openapi.dart';
import 'package:pomodoro_break/Set_Pomodoro/bloc/set_pomodoro_bloc.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';

import 'set_pomodoro_model.dart';
export 'set_pomodoro_model.dart';

class SetPomodoroWidget extends StatelessWidget {
  const SetPomodoroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetPomodoroBloc(navigate: (route) => context.go(route))..add(CheckExistingPomodoro()),
      child: SetPomodoroView(),
    );
  }
}

class SetPomodoroView extends StatelessWidget {
  final TextEditingController _totalWorkingHourController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: GlobalKey<ScaffoldState>(),
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderRadius: 8,
            buttonSize: 40,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {
              context.read<SetPomodoroBloc>().add(NavigateToInstructionPage());
            },
          ),
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
                  Text(
                    'Total Working Hour',
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily: 'Inter Tight',
                      color: FlutterFlowTheme.of(context).primaryText,
                      letterSpacing: 0.0,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _totalWorkingHourController,
                    decoration: InputDecoration(
                      labelText: 'Enter total working hours',
                      labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 32),
                  Material(
                    color: Colors.transparent,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
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
                      width: MediaQuery.of(context).size.width,
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
                            BlocBuilder<SetPomodoroBloc, SetPomodoroState>(
                              builder: (context, state) {
                                if (state is SetPomodoroInitial) {
                                  return Column(
                                    children: [
                                      Text(
                                        '${state.breakDuration} minutes',
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
                                          value: state.breakDuration.toDouble(),
                                          onChanged: (newValue) {
                                            context.read<SetPomodoroBloc>().add(UpdateBreakDuration(newValue.toInt()));
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
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              },
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
                      width: MediaQuery.of(context).size.width,
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
                  BlocBuilder<SetPomodoroBloc, SetPomodoroState>(
                    builder: (context, state) {
                      if (state is PomodoroExists) {
                        return Row(
                          children: [
                            Icon(Icons.warning, color: Colors.red),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'You have already created a Pomodoro. Complete it or delete the current Pomodoro to create a new one.',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      }
                      return FFButtonWidget(
                        onPressed: () async {
                          final jwtToken = Openapi.jwt;
                          if (jwtToken == null || jwtToken.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    Icon(Icons.error, color: Colors.white),
                                    SizedBox(width: 8),
                                    Text('Authentication token is missing. Please log in again.'),
                                  ],
                                ),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
                              ),
                            );
                            return;
                          }

                          if (state is PomodoroExists) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    Icon(Icons.warning, color: Colors.white),
                                    SizedBox(width: 8),
                                    Text('You have already created a Pomodoro. Complete it or delete the current Pomodoro to create a new one.'),
                                  ],
                                ),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
                              ),
                            );
                            return;
                          }

                          PomodoroBreakBuilder pomodoro = PomodoroBreakBuilder();
                    
                          pomodoro.totalWorkingHour = int.tryParse(_totalWorkingHourController.text) ?? 10;
                          pomodoro.dailyDurationOfWork = 25;
                          pomodoro.splitBreakDuration = 17;
                          pomodoro.breakDuration = (state as SetPomodoroInitial).breakDuration;
                          pomodoro.completedBreaks = 2;
                          pomodoro.dateOfPomodoro = DateTime.now().toUtc();
                          pomodoro.timeOfPomodoroCreation = DateTime.now().toUtc();
                          pomodoro.notificationForBreak = true;
                          pomodoro.finalMessage = "good job!";

                          final createdPomodoro = await Openapi().getPomodoroBreakResourceApi().createPomodoroBreak(
                            pomodoroBreak: pomodoro.build(),
                            headers: {'Authorization': 'Bearer $jwtToken'},
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Pomodoro created successfully! The ID is ${createdPomodoro.data?.id}')),
                          );

                          context.read<SetPomodoroBloc>().add(NavigateToHomePage());
                        },
                        text: 'Start Pomodoro',
                        options: FFButtonOptions(
                          width: MediaQuery.of(context).size.width,
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
                      );
                    },
                  ),
                ].divide(SizedBox(height: 32)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}