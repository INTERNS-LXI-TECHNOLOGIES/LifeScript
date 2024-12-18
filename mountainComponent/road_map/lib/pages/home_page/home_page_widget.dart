import 'package:lottie/lottie.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  Alignment _currentAlignment = Alignment(-0.55, 0.63);
  bool _isUnlocked = false;
  bool _isSecondLockUnlocked = false;
  bool _isThirdLockUnlocked = false;
  bool _isFourthLockUnlocked = false;
  bool _isFifthhLockUnlocked = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    _model.expandableExpandableController =
        ExpandableController(initialExpanded: false);

    // Initialize lock states for each position
  }

  void _levelUp() {
    setState(() {
      // Unlock current position
      if (_currentAlignment == Alignment(-0.55, 0.63)) {
        _currentAlignment = Alignment(-0.2, 0.54);
      } else if (_currentAlignment == Alignment(-0.2, 0.54)) {
        _currentAlignment = Alignment(-0.06, 0.36);
        _isUnlocked = true;
      } else if (_currentAlignment == Alignment(-0.06, 0.36)) {
        _currentAlignment = Alignment(0.12, 0.26);
      } else if (_currentAlignment == Alignment(0.12, 0.26)) {
        _currentAlignment = Alignment(0.36, 0.08);
        _isSecondLockUnlocked = true;
      } else if (_currentAlignment == Alignment(0.36, 0.08)) {
        _currentAlignment = Alignment(0.34, -0.03);
      } else if (_currentAlignment == Alignment(0.34, -0.03)) {
        _currentAlignment = Alignment(0.09, -0.14);
      } else if (_currentAlignment == Alignment(0.09, -0.14)) {
        _currentAlignment = Alignment(-0.23, -0.28);
        _isThirdLockUnlocked = true;
      } else if (_currentAlignment == Alignment(-0.23, -0.28)) {
        _currentAlignment = Alignment(-0.42, -0.35);
      } else if (_currentAlignment == Alignment(-0.42, -0.35)) {
        _currentAlignment = Alignment(-0.32, -0.47);
        _isFourthLockUnlocked = true;
      } else if (_currentAlignment == Alignment(-0.32, -0.47)) {
        _currentAlignment = Alignment(-0.08, -0.55);
      } else if (_currentAlignment == Alignment(-0.08, -0.55)) {
        _currentAlignment = Alignment(0.12, -0.7);
        _isFifthhLockUnlocked = true;
      }
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        top: true,
        child: Container(
          width: 840.0,
          height: 840.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Stack(children: [
            Container(
              width: double.infinity,
              color: Color(0x00000000),
              child: ExpandableNotifier(
                controller: _model.expandableExpandableController,
                child: ExpandablePanel(
                  header: Container(),
                  collapsed: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/Screenshot_2024-12-12_231326.png',
                                width: 393.0,
                                height: 704.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  expanded: Container(),
                  theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    tapBodyToExpand: false,
                    tapBodyToCollapse: false,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    hasIcon: true,
                  ),
                ),
              ),
            ),

            Align(
              alignment: AlignmentDirectional(-0.1, 0.44),
              child: !_isUnlocked
                  ? Icon(
                      Icons.lock_open_sharp, // Unlock icon
                      color: Color(0xFF340AEA),
                      size: 24.0,
                    )
                  : Lottie.asset(
                      'assets/jsons/flag.json', // Lock animation
                      width: 40,
                      height: 40,
                      repeat: true,
                    ),
            ),

            Align(
              alignment: AlignmentDirectional(0.28, 0.14),
              child: !_isSecondLockUnlocked
                  ? Icon(
                      Icons.lock_open_sharp, // Unlock icon
                      color: Color(0xFF340AEA),
                      size: 24.0,
                    )
                  : Lottie.asset(
                      'assets/jsons/flag.json', // Flag animation
                      width: 40,
                      height: 40,
                      repeat: true,
                    ),
            ),

            Align(
              alignment: AlignmentDirectional(-0.07, -0.21),
              child: !_isThirdLockUnlocked
                  ? Icon(
                      Icons.lock_open_sharp, // Unlock icon
                      color: Color(0xFF340AEA),
                      size: 24.0,
                    )
                  : Lottie.asset(
                      'assets/jsons/flag.json', // Flag animation
                      width: 40,
                      height: 40,
                      repeat: true,
                    ),
            ),

            Align(
              alignment: AlignmentDirectional(-0.48, -0.43),
              child: !_isFourthLockUnlocked
                  ? Icon(
                      Icons.lock_open_sharp, // Unlock icon
                      color: Color(0xFF340AEA),
                      size: 24.0,
                    )
                  : Lottie.asset(
                      'assets/jsons/flag.json', // Flag animation
                      width: 40,
                      height: 40,
                      repeat: true,
                    ),
            ),
            
             Align(
              alignment: AlignmentDirectional(0.03, -0.64),
              child: !_isFifthhLockUnlocked
                  ? Icon(
                      Icons.lock_open_sharp, // Unlock icon
                      color: Color(0xFF340AEA),
                      size: 24.0,
                    )
                  : Lottie.asset(
                      'assets/jsons/flag.json', // Flag animation
                      width: 40,
                      height: 40,
                      repeat: true,
                    ),
            ),

            // Animated Lottie asset
            AnimatedAlign(
              alignment: _currentAlignment,
              duration: Duration(seconds: 1), // Animation duration
              curve: Curves.easeInOut, // Smooth animation curve
              child: Lottie.asset(
                'assets/jsons/cycle.json',
                width: 40,
                height: 40,
                repeat: true,
              ),
            ),

            // Level Up button
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: _levelUp,
                child: Text("Level Up"),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.09, -0.14),
              child: FaIcon(
                FontAwesomeIcons.dotCircle,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 20.0,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.34, -0.03),
              child: FaIcon(
                FontAwesomeIcons.dotCircle,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 20.0,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.36, 0.08),
              child: FaIcon(
                FontAwesomeIcons.dotCircle,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 20.0,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.12, 0.26),
              child: FaIcon(
                FontAwesomeIcons.dotCircle,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 20.0,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-0.06, 0.36),
              child: FaIcon(
                FontAwesomeIcons.dotCircle,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 20.0,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-0.55, 0.63),
              child: FaIcon(
                FontAwesomeIcons.dotCircle,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 20.0,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-0.08, -0.55),
              child: FaIcon(
                FontAwesomeIcons.dotCircle,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 20.0,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-0.32, -0.47),
              child: FaIcon(
                FontAwesomeIcons.dotCircle,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 20.0,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.12, -0.7),
              child: FaIcon(
                FontAwesomeIcons.dotCircle,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 20.0,
              ),
            ),

            Align(
              alignment: AlignmentDirectional(0.73, -0.8),
              child: CircularPercentIndicator(
                percent: 1.0,
                radius: 45.0,
                lineWidth: 32.0,
                animation: true,
                animateFromLastPercent: true,
                progressColor: FlutterFlowTheme.of(context).primary,
                backgroundColor: FlutterFlowTheme.of(context).accent4,
                center: Text(
                  '100%',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Inter Tight',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 28.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.68, 0.47),
              child: CircularPercentIndicator(
                percent: 0.2,
                radius: 25.0,
                lineWidth: 32.0,
                animation: true,
                animateFromLastPercent: true,
                progressColor: FlutterFlowTheme.of(context).primary,
                backgroundColor: FlutterFlowTheme.of(context).accent4,
                center: Text(
                  '20%',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Inter Tight',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.56, -0.23),
              child: CircularPercentIndicator(
                percent: 0.6,
                radius: 35.0,
                lineWidth: 32.0,
                animation: true,
                animateFromLastPercent: true,
                progressColor: FlutterFlowTheme.of(context).primary,
                backgroundColor: FlutterFlowTheme.of(context).accent4,
                center: Text(
                  '65%',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Inter Tight',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 24.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.78, -0.49),
              child: CircularPercentIndicator(
                percent: 0.8,
                radius: 40.0,
                lineWidth: 32.0,
                animation: true,
                animateFromLastPercent: true,
                progressColor: FlutterFlowTheme.of(context).primary,
                backgroundColor: FlutterFlowTheme.of(context).accent4,
                center: Text(
                  '80%',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Inter Tight',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 26.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.72, 0.17),
              child: CircularPercentIndicator(
                percent: 0.4,
                radius: 30.0,
                lineWidth: 32.0,
                animation: true,
                animateFromLastPercent: true,
                progressColor: FlutterFlowTheme.of(context).primary,
                backgroundColor: FlutterFlowTheme.of(context).accent4,
                center: Text(
                  '40%',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Inter Tight',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
