import 'package:flutter/material.dart';
import 'package:habittracker/widget/user_form_app.dart';
  // Correct import // Adjusted import to point to the correct folder

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserForm(),  // Use the UserForm widget here
    );
  }
}
