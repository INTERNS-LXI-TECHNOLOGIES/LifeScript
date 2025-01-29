import 'package:dio/dio.dart';
import 'package:pomodoro_break/bloc/deletepage/delete_page_bloc.dart';
import 'package:pomodoro_break/bloc/deletepage/delete_page_event.dart';
import 'package:pomodoro_break/bloc/deletepage/delete_page_state.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/openapi.dart'; // Import OpenAPI package

import 'delete_page_model.dart';
export 'delete_page_model.dart';

class DeletePageWidget extends StatefulWidget {
  const DeletePageWidget({super.key});

  @override
  State<DeletePageWidget> createState() => _DeletePageWidgetState();
}

class _DeletePageWidgetState extends State<DeletePageWidget> {
  late DeletePageBloc _bloc;
  List<PomodoroBreak> _pomodoros = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _bloc = DeletePageBloc(navigate: (String route) {
      context.go(route); // Use GoRouter for navigation
    });
    _fetchPomodoros();
  }

  Future<void> _fetchPomodoros() async {
    try {
      final response = await Openapi().getPomodoroBreakResourceApi().getAllPomodoroBreaksAsStream(
        headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
      );
      setState(() {
        _pomodoros = response.data?.toList() ?? [];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch Pomodoros')),
      );
    }
  }

  @override
  void dispose() {
    _bloc.textController.dispose();
    _bloc.textFieldFocusNode.dispose();
    _bloc.close();
    super.dispose();
  }

  Future<void> deleteOperation(int id) async {
    try {
      final response = await Openapi().getPomodoroBreakResourceApi().getPomodoroBreak(
        id: id,
        headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
      );

      if (response.data != null) {
        await Openapi().getPomodoroBreakResourceApi().deletePomodoroBreak(
          id: id,
          headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pomodoro #$id deleted successfully!')),
        );
        //context.read<DeletePageBloc>().add(NavigateToHomePage());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pomodoro ID $id does not exist')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete Pomodoro $id')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderRadius: 8,
              buttonSize: 40,
              icon: Icon(
                Icons.arrow_back,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24,
              ),
              onPressed: () {
                context.go('/home'); // Navigate to home
              },
            ),
            title: Text(
              'Delete Pomodoro Break',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Inter Tight',
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 22,
                    letterSpacing: 0.0,
                  ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 2,
          ),
          body: SafeArea(
            top: true,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
              child: SingleChildScrollView(
                primary: false,
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
                                'Enter Pomodoro ID',
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      fontFamily: 'Inter Tight',
                                      color: FlutterFlowTheme.of(context).primary,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              BlocBuilder<DeletePageBloc, DeletePageState>(
                                builder: (context, state) {
                                  return TextFormField(
                                    controller: _bloc.textController,
                                    focusNode: _bloc.textFieldFocusNode,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter Tight',
                                            letterSpacing: 0.0,
                                          ),
                                      hintText: 'Enter ID to delete',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter Tight',
                                            letterSpacing: 0.0,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFE0E0E0),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 0, 0, 0),
                                      suffixIcon: Icon(
                                        Icons.delete,
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Inter Tight',
                                          letterSpacing: 0.0,
                                        ),
                                    minLines: 1,
                                    validator: _bloc.textControllerValidator
                                        .asValidator(context),
                                  );
                                },
                              ),
                              BlocBuilder<DeletePageBloc, DeletePageState>(
                                builder: (context, state) {
                                  return FFButtonWidget(
                                    onPressed: () async {
                                      final id = int.tryParse(_bloc.textController.text);
                                      if (id != null) {
                                        await deleteOperation(id);
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Please enter a valid ID')),
                                        );
                                      }
                                    },
                                    text: 'Delete Pomodoro',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width,
                                      height: 50,
                                      padding: EdgeInsets.all(8),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                      color: FlutterFlowTheme.of(context).error,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Inter Tight',
                                            color: FlutterFlowTheme.of(context).info,
                                            letterSpacing: 0.0,
                                          ),
                                      elevation: 3,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  );
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
                                'Existing Pomodoros',
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      fontFamily: 'Inter Tight',
                                      color: FlutterFlowTheme.of(context).primary,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: _pomodoros.map((pomodoro) {
                                  return Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 16, 16, 16),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Pomodoro #${pomodoro.id}',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyLarge
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      color: FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                              ),
                                              Text(
                                                'Total duration of work: ${pomodoro.totalWorkingHour} Hours • Work: ${pomodoro.dailyDurationOfWork} min • Break: ${pomodoro.breakDuration} min',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Inter Tight',
                                                      color: FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                      letterSpacing: 0.0,
                                                    ),
                                              ),
                                              Text(
                                                'Created: ${pomodoro.dateOfPomodoro} at ${pomodoro.timeOfPomodoroCreation}',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Inter Tight',
                                                      color: FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                      letterSpacing: 0.0,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete_outline,
                                              color: FlutterFlowTheme.of(context).error,
                                              size: 24,
                                            ),
                                            onPressed: () async {
                                              if (pomodoro.id != null) {
                                                await deleteOperation(pomodoro.id!);
                                              }
                                              await _fetchPomodoros();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList().divide(SizedBox(height: 12)),
                              ),
                            ].divide(SizedBox(height: 16)),
                          ),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 24)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
