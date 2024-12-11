import '/components/pepproni_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  final scaffoldKey = GlobalKey<ScaffoldState>();

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Container(
                  width: 375.0,
                  height: 462.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 2.11),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              'https://i.pinimg.com/736x/13/64/0b/13640bacbb517698727c364a7d488450.jpg',
                              height: 400.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.72, 0.21),
                          child: wrapWithModel(
                            model: _model.pepproniModel1,
                            updateCallback: () => safeSetState(() {}),
                            child: PepproniWidget(),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.43, -0.17),
                          child: wrapWithModel(
                            model: _model.pepproniModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: PepproniWidget(),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-0.54, -0.02),
                          child: wrapWithModel(
                            model: _model.pepproniModel3,
                            updateCallback: () => safeSetState(() {}),
                            child: PepproniWidget(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.09, -0.17),
                child: wrapWithModel(
                  model: _model.pepproniModel4,
                  updateCallback: () => safeSetState(() {}),
                  child: PepproniWidget(),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.1, 0.53),
                child: wrapWithModel(
                  model: _model.pepproniModel5,
                  updateCallback: () => safeSetState(() {}),
                  child: PepproniWidget(),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.54, 0.37),
                child: wrapWithModel(
                  model: _model.pepproniModel6,
                  updateCallback: () => safeSetState(() {}),
                  child: PepproniWidget(),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.37, 0.45),
                child: wrapWithModel(
                  model: _model.pepproniModel7,
                  updateCallback: () => safeSetState(() {}),
                  child: PepproniWidget(),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.65, 0.25),
                child: wrapWithModel(
                  model: _model.pepproniModel8,
                  updateCallback: () => safeSetState(() {}),
                  child: PepproniWidget(),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.27, 0.32),
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).warning,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.14, -0.24),
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).warning,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.65, -0.06),
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).warning,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.39, 0.18),
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).warning,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.46, -0.14),
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).warning,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.4, 0.17),
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).warning,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
