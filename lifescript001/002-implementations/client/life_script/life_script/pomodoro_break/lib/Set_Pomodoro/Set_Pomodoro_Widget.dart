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
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

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

class SetPomodoroView extends StatefulWidget {
  @override
  _SetPomodoroViewState createState() => _SetPomodoroViewState();
}

class _SetPomodoroViewState extends State<SetPomodoroView> {
  List<Widget> droppedItems = [];
  List<Widget> breakTimeTips = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    breakTimeTips = _buildBreakTimeTips();
  }

  List<Widget> _buildBreakTimeTips() {
    return [
      _buildDraggableTip(
        icon: Icons.directions_walk,
        title: 'Take a short walk',
        description: 'Clear your mind with light exercise',
      ),
      _buildDraggableTip(
        icon: Icons.local_drink,
        title: 'Stay hydrated',
        description: 'Remember to drink water',
      ),
      _buildDraggableTip(
        icon: Icons.self_improvement,
        title: 'Quick meditation',
        description: 'Practice mindful breathing',
      ),
      _buildDraggableTip(
        icon: Icons.scale,
        title: 'Quick nap',
        description: 'Take a quick deep nap on break time',
      ),
      _buildDraggableTip(
        icon: Icons.remove_red_eye,
        title: 'Eye Relaxation',
        description: 'Look away from the screen or do palming',
      ),
    ];
  }

  Widget _buildDraggableTip({required IconData icon, required String title, required String description}) {
    final tipWidget = _buildTipContainer(icon: icon, title: title, description: description);
    return Draggable<Widget>(
      data: tipWidget,
      feedback: Material(
        color: Colors.transparent,
        child: tipWidget
      ),
      childWhenDragging: Container(),
      child: tipWidget,
    );
  }

  Widget _buildTipContainer({required IconData icon, required String title, required String description}) {
    return Container(
      width: 290,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: FlutterFlowTheme.of(context).primary,
              size: 32.0,
            ),
            Text(
              title,
              style: FlutterFlowTheme.of(context).bodyLarge.override(
                    fontFamily: 'Inter',
                    color: FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                  ),
            ),
            Text(
              description,
              style: FlutterFlowTheme.of(context).bodySmall.override(
                    fontFamily: 'Inter',
                    color: FlutterFlowTheme.of(context).secondaryText,
                    letterSpacing: 0.0,
                  ),
            ),
          ].divide(SizedBox(height: 8.0)),
        ),
      ),
    );
  }

  Widget _buildDroppedTipContainer(Widget tip) {
    return Container(
      width: 290,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
            child: tip,
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  droppedItems.remove(tip);
                  breakTimeTips.add(tip);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
                  SizedBox(height: 32),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 250.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Break Time Tips',
                                style: FlutterFlowTheme.of(context).headlineSmall.override(
                                      fontFamily: 'Inter Tight',
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              Container(
                                height: 120.0,
                                child: ListView(
                                  padding: EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: breakTimeTips
                                      .map((tip) => Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: tip,
                                          ))
                                      .toList(),
                                ),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
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
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Drop your Break Tips',
                                style: FlutterFlowTheme.of(context).headlineSmall.override(
                                      fontFamily: 'Inter Tight',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              Container(
                                height: 180.0,
                                child: DragTarget<Widget>(
                                  builder: (context, candidateData, rejectedData) {
                                    return ListView(
                                      padding: EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        ...droppedItems
                                            .map((item) => Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: _buildDroppedTipContainer(item),
                                                ))
                                            .toList(),
                                        Container(
                                          width: 250.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                            borderRadius: BorderRadius.circular(12.0),
                                            border: Border.all(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Drop here',
                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                    fontFamily: 'Inter',
                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  onAccept: (data) {
                                    if (droppedItems.contains(data)) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Tip already added'),
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
                                        ),
                                      );
                                    } else {
                                      setState(() {
                                        droppedItems.add(data);
                                        breakTimeTips.remove(data);
                                      });
                                    }
                                  },
                                ),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
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
                    
                          pomodoro.totalWorkingHour = 8;
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