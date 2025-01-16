import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/circular_menu/Circular_Menu.dart'; // Import the custom CircularMenu

import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to Pomodoro Break',
                      style: FlutterFlowTheme.of(context).headlineMedium.override(
                            fontFamily: 'Inter Tight',
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    FFButtonWidget(
                      onPressed: () {
                          print('Entered the HomePage ...');
                          context.go('/InfoPage');
                      },
                      text: 'Set Pomodoro',
                      options: FFButtonOptions(
                        width: 200,
                        height: 50,
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Inter Tight',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                        elevation: 3,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CircularMenu(
                menuButtons: [
                  MenuButton(
                    icon: Icons.home,
                    tooltip: 'Home',
                    offset: Offset(0, -100),
                    onPressed: () {
                      print('Home button pressed');
                    },
                    color: Colors.red,
                  ),
                  MenuButton(
                    icon: Icons.settings,
                    tooltip: 'Settings',
                    offset: Offset(100, 0),
                    onPressed: () {
                      print('Settings button pressed');
                    },
                    color: Colors.green,
                  ),
                  MenuButton(
                    icon: Icons.info,
                    tooltip: 'Info',
                    offset: Offset(-100, 0),
                    onPressed: () {
                      print('Info button pressed');
                    },
                    color: Colors.purple,
                  ),
                  MenuButton(
                    icon: Icons.delete,
                    tooltip: 'Delete',
                    offset: Offset(0,100),
                    onPressed: () {
                      print('Delete button pressed');
                    },
                    color: const Color.fromARGB(255, 35, 183, 171),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}