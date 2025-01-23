import 'package:flutter/material.dart';
import 'package:habittracker/widget/habit_track_homepagewidget.dart';
import 'package:habittracker/widget/habit_tracker_widget.dart';
import 'package:habittracker/widget/habittrack_homepage_widgetwidget.dart';


void main() {
  runApp(MyApp());
 


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HabittrackhomepagewidgetWidget(),
    );
  }
}
