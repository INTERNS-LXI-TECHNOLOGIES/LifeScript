import 'package:flutter/material.dart';
import 'contact_creation_page.dart'; // Import the ContactCreationPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ContactCreationPage(), // Set ContactCreationPage as the home screen
    );
  }
}
