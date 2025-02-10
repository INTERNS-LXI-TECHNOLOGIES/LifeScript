import 'package:flutter/material.dart';
import 'package:habittracker/widget/TetrisGameScreen.dart';
import 'package:habittracker/widget/dark_glassmorphic.dart';
import 'package:habittracker/widget/habittrack_homepage_widgetwidget.dart';
import 'package:habittracker/widget/loginWidget.dart';
import 'package:habittracker/widget/victory_streaks_widget.dart';

import 'package:habittracker_openapi/openapi.dart';

void main() {
  final openApi = Openapi(); 
  runApp(MyApp(openApi: openApi));
}

class MyApp extends StatelessWidget {
  final Openapi openApi;

  const MyApp({Key? key, required this.openApi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
       
         primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: VictoryStreaksWidget(),
      routes: {
        '/home': (context) => VictoryStreaksWidget(),
      },
    );
  }
}