import 'package:flutter/material.dart';
import 'package:habittracker/widget/dark_glassmorphic.dart';
import 'package:habittracker/widget/habittrack_homepage_widgetwidget.dart';
import 'package:habittracker/widget/loginWidget.dart';
import 'package:habittracker/widget/puzzle_shape.dart';
import 'package:habittracker/widget/shape_drag_screen.dart';
import 'package:habittracker_openapi/openapi.dart';

void main() {
  final openApi = Openapi(); // Initialize your Openapi instance here
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
      home: LoginWidget(),
      routes: {
        '/home': (context) => TetrisGameScreen(),
      },
    );
  }
}