import 'package:flutter/material.dart';
import 'package:habittracker/widget/habit_track_homepagewidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HabittrackhomepageWidget(),
    );
  }
}
