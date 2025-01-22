import 'package:flutter/material.dart';
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
