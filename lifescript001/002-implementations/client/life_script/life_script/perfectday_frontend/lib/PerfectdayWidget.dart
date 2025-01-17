import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/openapi.dart';
import 'package:perfectday_frontend/PerfectdayModel.dart';
import 'package:perfectday_frontend/blocs/day_plan_bloc.dart';
import 'package:perfectday_frontend/events/day_plan_event.dart';
import 'package:perfectday_frontend/state/day_plan_state.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

///import 'perfectdayplan1_model.dart';
//export 'perfectdayplan1_model.dart';

class Perfectdayplan1Widget extends StatefulWidget {
  const Perfectdayplan1Widget({super.key});

  @override
  State<Perfectdayplan1Widget> createState() => _Perfectdayplan1WidgetState();
}

class _Perfectdayplan1WidgetState extends State<Perfectdayplan1Widget> {
  late Perfectdayplan1Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Perfectdayplan1Model());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();
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
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderRadius: 8,
            buttonSize: 40,
            fillColor: Colors.transparent,
            icon: Icon(
              Icons.arrow_back,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
          title: Text(
            'My Day Planner',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter Tight',
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
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
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'March 15, 2024',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: 'Inter Tight',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                FlutterFlowIconButton(
                                  borderRadius: 20,
                                  buttonSize: 40,
                                  fillColor: Color(0xFFF5F5F5),
                                  icon: Icon(
                                    Icons.calendar_today,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
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
                              'Add New Goal',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Inter Tight',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            TextFormField(
                              controller: _model.textController1,
                              focusNode: _model.textFieldFocusNode1,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Goal Title',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: 'Inter',
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
                                fillColor: Color(0xFFF5F5F5),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                              minLines: 1,
                              validator: _model.textController1Validator
                                  .asValidator(context),
                            ),
                            TextFormField(
                              controller: _model.textController2,
                              focusNode: _model.textFieldFocusNode2,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: 'Inter',
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
                                fillColor: Color(0xFFF5F5F5),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                              maxLines: 4,
                              minLines: 3,
                              validator: _model.textController2Validator
                                  .asValidator(context),
                            ),
                            FFButtonWidget(
                              onPressed: () {
                                final title = _model.textController1.text;
                                final desc = _model.textController2.text;
                                DayPlanControllerApi api =
                                    Openapi().getDayPlanControllerApi();

                                context
                                    .read<DayPlanBloc>()
                                    .add(CreateDayPlanEvent(title: title, description: desc));
                                print('Button pressed ...');
                              },
                              text: 'Add Goal',
                              options: FFButtonOptions(
                                width: MediaQuery.sizeOf(context).width,
                                height: 56,
                                padding: EdgeInsets.all(8),
                                iconPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Inter Tight',
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 3,
                                borderRadius: BorderRadius.circular(28),
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
                              'Today\'s Goals',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Inter Tight',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 16, 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
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
                                              'Complete Project Presentation',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                            ),
                                            Text(
                                              'Finalize slides and practice delivery',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            FlutterFlowIconButton(
                                              borderRadius: 20,
                                              buttonSize: 40,
                                              fillColor: Color(0xFFE3F2FD),
                                              icon: Icon(
                                                Icons.edit,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                print('IconButton pressed ...');
                                              },
                                            ),
                                            FlutterFlowIconButton(
                                              borderRadius: 20,
                                              buttonSize: 40,
                                              fillColor: Color(0xFFFFEBEE),
                                              icon: Icon(
                                                Icons.delete_outline,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                print('IconButton pressed ...');
                                              },
                                            ),
                                          ].divide(SizedBox(width: 8)),
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(height: 12)),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 16, 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
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
                                              'Gym Session',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                            ),
                                            Text(
                                              '45-minute strength training',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            FlutterFlowIconButton(
                                              borderRadius: 20,
                                              buttonSize: 40,
                                              fillColor: Color(0xFFE3F2FD),
                                              icon: Icon(
                                                Icons.edit,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                print('IconButton pressed ...');
                                              },
                                            ),
                                            FlutterFlowIconButton(
                                              borderRadius: 20,
                                              buttonSize: 40,
                                              fillColor: Color(0xFFFFEBEE),
                                              icon: Icon(
                                                Icons.delete_outline,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                print('IconButton pressed ...');
                                                
  BlocBuilder<DayPlanBloc, DayPlanState>(
  builder: (context, state) {
    if (state is DayPlanInitialState) {
      return Text(
        'Welcome! No day plan data available.',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      );
    } else if (state is DayPlanLoadingState) {
      return CircularProgressIndicator(); // Show a loading spinner
    } else if (state is DayPlanSuccessState) {
      return Text(
        state.title, // Display the success message
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
      );
    } else if (state is DayPlanErrorState) {
      return Text(
        state.errorMessage, // Display the error message
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
      );
    } else {
      return Text(
        'Unexpected state!',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      );
    }
  },
);


                                              },
                                            ),
                                          ].divide(SizedBox(width: 8)),
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(height: 12)),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 16, 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
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
                                              'Team Meeting',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                            ),
                                            Text(
                                              'Weekly sync with development team',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            FlutterFlowIconButton(
                                              borderRadius: 20,
                                              buttonSize: 40,
                                              fillColor: Color(0xFFE3F2FD),
                                              icon: Icon(
                                                Icons.edit,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                print('IconButton pressed ...');
                                              },
                                            ),
                                            FlutterFlowIconButton(
                                              borderRadius: 20,
                                              buttonSize: 40,
                                              fillColor: Color(0xFFFFEBEE),
                                              icon: Icon(
                                                Icons.delete_outline,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                print('IconButton pressed ...');
                                              },
                                            ),
                                          ].divide(SizedBox(width: 8)),
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(height: 12)),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 16, 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
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
                                              'Read Book',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                            ),
                                            Text(
                                              '30 minutes of reading',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            FlutterFlowIconButton(
                                              borderRadius: 20,
                                              buttonSize: 40,
                                              fillColor: Color(0xFFE3F2FD),
                                              icon: Icon(
                                                Icons.edit,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                print('IconButton pressed ...');
                                              },
                                            ),
                                            FlutterFlowIconButton(
                                              borderRadius: 20,
                                              buttonSize: 40,
                                              fillColor: Color(0xFFFFEBEE),
                                              icon: Icon(
                                                Icons.delete_outline,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                size: 20,
                                              ),
                                              onPressed: () {
             

                                                print('IconButton pressed ...');
                                              },
                                            ),
                                          ].divide(SizedBox(width: 8)),
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(height: 12)),
                                ),
                              ),
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
    );
  }
}
