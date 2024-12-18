import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/components/lock_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
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

  bool isLocked = true;
  bool isLocked1 = true;
  bool isLocked2 = true;

  final List<bool> _levelStates = List.generate(10, (_) => false);
  final List<Alignment> _levelAlignments = [
    Alignment(-0.1, 0.57),
    Alignment(0.02, 0.25),
    Alignment(-0.02, 0.34),
    Alignment(-0.05, 0.5),
    Alignment(0.03, -0.74),
    Alignment(0.12, 0.05),
    Alignment(0.11, -0.07),
    Alignment(0.05, -0.17),
    Alignment(-0.06, -0.31),
    Alignment(-0.1, -0.37),
  ];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
  }

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
        child: Stack(
          children: [
            _buildBackgroundImage(),
            _buildLevelIndicators(),
            _buildIconOnPageLoad(),
            _buildProgressIndicators(),
            _buildLockWidgets(),
            _buildLockToggleButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        height: 1200.0,
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
    );
  }

  Widget _buildLevelIndicators() {
    return Stack(
      children: List.generate(
        _levelStates.length,
        (index) => Align(
          alignment: _levelAlignments[index],
          child: InkWell(
            onTap: () {
              setState(() {
                _levelStates[index] = true; // Mark level as completed
              });
            },
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: Container(
                key: ValueKey<bool>(_levelStates[index]),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _levelStates[index] ? Colors.green : Colors.red,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    _levelStates[index] ? '✓' : '!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconOnPageLoad() {
    return Align(
      alignment: AlignmentDirectional(-0.16, 0.6),
      child: Icon(
        Icons.golf_course_sharp,
        color: Colors.blue, // Choose your color here
        size: 34.0,
      ).animate().fadeIn(
          duration: Duration(milliseconds: 800)), // Apply fade-in animation
    );
    // Direct fade-in animation
  }

  Widget _buildProgressIndicators() {
    return Column(
      children: [
        _buildProgressIndicator(0.25, '25%', 0.41),
        _buildProgressIndicator(0.9, '95%', 0.16),
        _buildProgressIndicator(0.3, '40%', 0.14),
        _buildProgressIndicator(0.8, '85%', -0.62),
        _buildProgressIndicator(0.6, '60%', -0.23),
        _buildProgressIndicator(0.7, '70%', -0.42),
      ],
    );
  }

  Widget _buildProgressIndicator(
      double percent, String label, double alignmentY) {
    return Align(
      alignment: AlignmentDirectional(0.16, alignmentY),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
        child: CircularPercentIndicator(
          percent: percent,
          radius: 20.0,
          lineWidth: 18.0,
          animation: true,
          animateFromLastPercent: true,
          progressColor: FlutterFlowTheme.of(context).warning,
          backgroundColor: FlutterFlowTheme.of(context).secondary,
          center: Text(
            label,
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter Tight',
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  fontSize: 12.0,
                  letterSpacing: 0.0,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildLockWidgets() {
    return Stack(
      children: [
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
      ],
    );
  }

  Widget _buildLockToggleButtons() {
    return Column(
      children: [
        _buildLockToggleButton(
            isLocked, () => setState(() => isLocked = !isLocked)),
        _buildLockToggleButton(
            isLocked1, () => setState(() => isLocked1 = !isLocked1)),
        _buildLockToggleButton(
            isLocked2, () => setState(() => isLocked2 = !isLocked2)),
      ],
    );
  }

  Widget _buildLockToggleButton(bool isLockedState, VoidCallback toggleLock) {
    return Align(
      alignment: AlignmentDirectional(-0.02, -0.24),
      child: GestureDetector(
        onTap: toggleLock,
        child: FaIcon(
          isLockedState ? FontAwesomeIcons.lock : FontAwesomeIcons.lockOpen,
          color: FlutterFlowTheme.of(context).secondaryBackground,
          size: 24,
        ),
      ),
    );
  }
}
