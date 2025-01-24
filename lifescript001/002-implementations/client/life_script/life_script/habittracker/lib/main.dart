import 'package:flutter/material.dart';
import 'package:habittracker/widget/habittrack_homepage_widgetwidget.dart';
import 'package:habittracker/widget/loginWidget.dart';


void main() {
  runApp(MyApp());
 


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginWidget(),
    );
  }
}
