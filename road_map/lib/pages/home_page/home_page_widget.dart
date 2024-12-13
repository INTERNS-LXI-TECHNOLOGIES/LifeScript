import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/components/lock_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    animationsMap.addAll({
      'iconOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(1.0, 1.0),
          ),
        ],
        effects: [],
      ),
      'progressBarOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
        effects: [],
      ),
      'iconOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 700.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
        effects: [],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  bool isLocked = true;
    bool isLocked1 = true;
     bool isLocked2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Container(
                height: 1200.0,
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryText,
                          shape: BoxShape.rectangle,
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(22.0),
                                child: Image.asset(
                                  'assets/images/Screenshot_2024-12-12_231326.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-0.16, 0.6),
                      child: Icon(
                        Icons.golf_course_sharp,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        size: 34.0,
                      ).animateOnPageLoad(
                          animationsMap['iconOnPageLoadAnimation1']!),
                    ),
                  

                      
Align(
alignment: AlignmentDirectional(-0.02, -0.24),  
child: GestureDetector(
    onTap: () {
      // Toggle the state of the lock
      setState(() {
        isLocked = !isLocked; // Toggle the lock state
      });
    },
    child: FaIcon(
      isLocked ? FontAwesomeIcons.lock : FontAwesomeIcons.lockOpen, // Toggle between lock and unlock
      color: FlutterFlowTheme.of(context).secondaryBackground,
      size: 24,
    ),
  ),
),



                    
                   
                    Align(
                      alignment: AlignmentDirectional(0.15, 0.41),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                        child: CircularPercentIndicator(
                          percent: 0.25,
                          radius: 20.0,
                          lineWidth: 18.0,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: FlutterFlowTheme.of(context).warning,
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondary,
                          center: Text(
                            '25%',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: 'Inter Tight',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.16, -0.7),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                        child: CircularPercentIndicator(
                          percent: 0.9,
                          radius: 25.0,
                          lineWidth: 23.0,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: FlutterFlowTheme.of(context).warning,
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondary,
                          center: Text(
                            '95%',
                            style: FlutterFlowTheme.of(context)
                                .displaySmall
                                .override(
                                  fontFamily: 'Inter Tight',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.16, 0.14),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                        child: CircularPercentIndicator(
                          percent: 0.3,
                          radius: 20.0,
                          lineWidth: 18.0,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: FlutterFlowTheme.of(context).warning,
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondary,
                          center: Text(
                            '40%',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: 'Inter Tight',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-0.08, -0.62),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                        child: CircularPercentIndicator(
                          percent: 0.8,
                          radius: 20.0,
                          lineWidth: 18.0,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: FlutterFlowTheme.of(context).warning,
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondary,
                          center: Text(
                            '85%',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: 'Inter Tight',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.13, -0.23),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                        child: CircularPercentIndicator(
                          percent: 0.6,
                          radius: 37.5,
                          lineWidth: 23.0,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: FlutterFlowTheme.of(context).warning,
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondary,
                          center: Text(
                            '60%',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: 'Inter Tight',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        ).animateOnPageLoad(
                            animationsMap['progressBarOnPageLoadAnimation']!),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.16, -0.42),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                        child: CircularPercentIndicator(
                          percent: 0.7,
                          radius: 20.0,
                          lineWidth: 22.0,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: FlutterFlowTheme.of(context).warning,
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondary,
                          center: Text(
                            '70%',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: 'Inter Tight',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.06, -0.7),
                      child: wrapWithModel(
                        model: _model.lockModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: LockWidget(),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, -0.61),
                      child: wrapWithModel(
                        model: _model.lockModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: LockWidget(),
                      ),
                    ),
                   
                     Align(
                      alignment: AlignmentDirectional(-0.02, 0.37),
child: GestureDetector(
    onTap: () {
      // Toggle the state of the lock
      setState(() {
        isLocked1 = !isLocked1; // Toggle the lock state
      });
    },
    child: FaIcon(
      isLocked1 ? FontAwesomeIcons.lock : FontAwesomeIcons.lockOpen, // Toggle between lock and unlock
      color: FlutterFlowTheme.of(context).secondaryBackground,
      size: 24,
    ),
  ),
),

 
                  Align(
alignment: AlignmentDirectional(0.06, 0.12),  
child: GestureDetector(
    onTap: () {
      // Toggle the state of the lock
      setState(() {
        isLocked2 = !isLocked2; // Toggle the lock state
      });
    },
    child: FaIcon(
      isLocked2 ? FontAwesomeIcons.lock : FontAwesomeIcons.lockOpen, // Toggle between lock and unlock
      color: FlutterFlowTheme.of(context).secondaryBackground,
      size: 24,
    ),
  ),
),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
