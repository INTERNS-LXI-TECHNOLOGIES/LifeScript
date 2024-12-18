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

  Alignment _currentAlignment = Alignment(-0.35, 0.63);
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
      if (_currentAlignment == Alignment(-0.35, 0.63)) {
        _currentAlignment = Alignment(-0.2, 0.54);
      } else if (_currentAlignment == Alignment(-0.2, 0.54)) {
        _currentAlignment = Alignment(-0.06, 0.36);
        _isUnlocked = true;
      } else if (_currentAlignment == Alignment(-0.06, 0.36)) {
        _currentAlignment = Alignment(-0.05, 0.24);

      } else if (_currentAlignment == Alignment(-0.05, 0.24)) {
        _currentAlignment = Alignment(0.12, 0.04);
        _isSecondLockUnlocked = true;

      } else if (_currentAlignment == Alignment(0.12, 0.04)) {
        _currentAlignment = Alignment(0.22, -0.02);

      } else if (_currentAlignment == Alignment(0.22, -0.02)) {
        _currentAlignment = Alignment(0.10, -0.14);

      } else if (_currentAlignment == Alignment(0.10, -0.14)) {
        _currentAlignment = Alignment(-0.06, -0.35);
        _isThirdLockUnlocked = true;

      } else if (_currentAlignment == Alignment(-0.06, -0.35)) {
        _currentAlignment = Alignment(-0.21, -0.38);

      } else if (_currentAlignment == Alignment(-0.21, -0.38)) {
        _currentAlignment = Alignment(-0.22, -0.47);
        _isFourthLockUnlocked = true;
      } else if (_currentAlignment == Alignment(-0.22, -0.47)) {
        _currentAlignment = Alignment(-0.12, -0.55);
      } else if (_currentAlignment == Alignment(-0.12, -0.55)) {
        _currentAlignment = Alignment(0.03, -0.78);
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

  Widget _showMotivationalPopup(BuildContext context) {
  // Show a dialog with a motivational message
  Future.delayed(Duration.zero, () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You Got This!'),
          content: Text('Keep pushing forward, you are doing great!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Okay'),
            ),
          ],
        );
      },
    );
  });
  return Container(); // Return an empty container (the popup is handled by the dialog)
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
  alignment: _currentAlignment, // Align based on current alignment
  child: _currentAlignment == Alignment(-0.2, 0.54)
      ? Align(
          alignment: Alignment(-0.2, 0.34), // Position the animation at this point
          child: Lottie.asset(
            'assets/jsons/cloudyrain.json', // Cloudy rain animation
            width: 85,
            height: 70,
            repeat: true, // Make sure it repeats
          ),
        )
      : Container(), // Show nothing if alignment doesn't match
),

Align(
  alignment: _currentAlignment, // Align based on current alignment
  child: _currentAlignment == Alignment(-0.05, 0.24)
      ? Stack(
          children: [
            Align(
              alignment: Alignment(0.08, 0.14), // Position the animation at this point
              child: Lottie.asset(
                'assets/jsons/thunder.json', // Thunder animation
                width: 65,
                height: 60,
                repeat: true, // Make sure it repeats
              ),
            ),
            // Check if the alignment matches and show popup
            if (_currentAlignment == Alignment(-0.05, 0.24))
              _showMotivationalPopup(context), // Show the popup
          ],
        )
      : Container(), // Show nothing if alignment doesn't match
)
,


            Align(
              alignment: AlignmentDirectional(-0.1, 0.44),
              child: !_isUnlocked
                  ? Lottie.asset(
          'assets/jsons/mountain.json', // Mountain animation
          width: 35,
          height: 35,
          repeat: true,
        )
                  : Lottie.asset(
                      'assets/jsons/flag.json', // Lock animation
                      width: 50,
                      height: 50,
                      repeat: true,
                    ),
            ),

            Align(
              alignment: AlignmentDirectional(0.08, 0.14),
              child: !_isSecondLockUnlocked
                  ? Lottie.asset(
          'assets/jsons/mountain.json', // Mountain animation
          width: 35,
          height: 35,
          repeat: true,
        )
                  : Lottie.asset(
                      'assets/jsons/flag.json', // Flag animation
                      width: 50,
                      height: 50,
                      repeat: true,
                    ),
            ),

            Align(
              alignment: AlignmentDirectional(0.00, -0.21),
              child: !_isThirdLockUnlocked
                  ? Lottie.asset(
          'assets/jsons/mountain.json', // Mountain animation
          width: 35,
          height: 35,
          repeat: true,
        )
                  : Lottie.asset(
                      'assets/jsons/flag.json', // Flag animation
                      width: 50,
                      height: 50,
                      repeat: true,
                    ),
            ),

            Align(
              alignment: AlignmentDirectional(-0.22, -0.43),
              child: !_isFourthLockUnlocked
                  ? Lottie.asset(
          'assets/jsons/mountain.json', // Mountain animation
          width: 35,
          height: 35,
          repeat: true,
        )
                  : Lottie.asset(
                      'assets/jsons/flag.json', // Flag animation
                      width: 50,
                      height: 50,
                      repeat: true,
                    ),
            ),

            Align(
              alignment: AlignmentDirectional(0.01, -0.64),
              child: !_isFifthhLockUnlocked
                 ? Lottie.asset(
          'assets/jsons/mountain.json', // Mountain animation
          width: 35,
          height: 35,
          repeat: true,
        )
                  : Lottie.asset(
                      'assets/jsons/flag.json', // Flag animation
                      width: 50,
                      height: 50,
                      repeat: true,
                    ),
            ),

            // Animated Lottie asset
            AnimatedAlign(
              alignment: _currentAlignment,
              duration: Duration(seconds: 1), // Animation duration
              curve: Curves.easeInOut, // Smooth animation curve
              child: Lottie.asset(
                'assets/jsons/olympic-athlete.json',
                width: 60,
                height: 60,
                repeat: true,
              ),
            ),

            // Level Up button
            Align(
              alignment: Alignment.topLeft,
              child: ElevatedButton(
                onPressed: _levelUp,
                child: Text("Level Up"),
              ),
            ),
           
           
        

          Align(
  alignment: AlignmentDirectional(0.36, -0.8),
  child: CircularPercentIndicator(
    percent: 1.0,
    radius: 45.0,
    lineWidth: 32.0,
    animation: true,
    animateFromLastPercent: true,
    animationDuration: 8000, // Set duration of animation in milliseconds (e.g., 5000 ms = 5 seconds)
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
              alignment: AlignmentDirectional(0.29, 0.39),
              child: CircularPercentIndicator(
                percent: 0.2,
                radius: 25.0,
                lineWidth: 32.0,
                animation: true,
                animateFromLastPercent: true,
                  animationDuration: 4000, 
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
              alignment: AlignmentDirectional(0.23, -0.28),
              child: CircularPercentIndicator(
                percent: 0.6,
                radius: 35.0,
                lineWidth: 32.0,
                animation: true,
                animateFromLastPercent: true,
                  animationDuration: 6000, 
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
              alignment: AlignmentDirectional(0.33, -0.49),
              child: CircularPercentIndicator(
                percent: 0.8,
                radius: 40.0,
                lineWidth: 32.0,
                animation: true,
                animateFromLastPercent: true,
                  animationDuration: 7000, 
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
              alignment: AlignmentDirectional(0.30, 0.13),
              child: CircularPercentIndicator(
                percent: 0.4,
                radius: 30.0,
                lineWidth: 32.0,
                animation: true,
                animateFromLastPercent: true,
                  animationDuration: 5000, 
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
