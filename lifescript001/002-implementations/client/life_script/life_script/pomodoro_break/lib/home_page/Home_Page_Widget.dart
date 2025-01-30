import 'package:pomodoro_break/home_page/bloc/home_page_bloc.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(navigate: (route) => context.go(route)),
      child: HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: GlobalKey<ScaffoldState>(),
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
                    BlocBuilder<HomePageBloc, HomePageState>(
                      builder: (context, state) {
                        return FFButtonWidget(
                          onPressed: () {
                            context.read<HomePageBloc>().add(NavigateToInfoPage());
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
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CircularMenu(
                alignment: Alignment.bottomCenter,
                radius: 100,
                items: [
                  CircularMenuItem(
                    icon: Icons.home,
                    onTap: () {
                      print('Home button pressed');
                    },
                    color: Colors.red,
                  ),
                  CircularMenuItem(
                    icon: Icons.settings,
                    onTap: () {
                      print('Settings button pressed');
                    },
                    color: Colors.green,
                  ),
                  CircularMenuItem(
                    icon: Icons.info,
                    onTap: () {
                      print('Info button pressed');
                    },
                    color: Colors.purple,
                  ),
                  CircularMenuItem(
                    icon: Icons.delete,
                    onTap: () {
                      context.read<HomePageBloc>().add(NavigateToDeletePage());
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