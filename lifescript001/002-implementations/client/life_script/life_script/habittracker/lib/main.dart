import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habittracker/bloc/homepage/habit_track_bloc.dart';
import 'package:habittracker_openapi/openapi.dart';
import 'package:habittracker/widget/habittrack_homepage_widgetwidget.dart';
import 'package:habittracker/widget/loginWidget.dart';

void main() {
  final openApi = Openapi(); // Initialize your Openapi instance here

  runApp(MyApp(openApi: openApi));
}

class MyApp extends StatelessWidget {
  final Openapi openApi;

  const MyApp({Key? key, required this.openApi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HabitTrackBloc(openApi: openApi),
        ),
      ],
      child: MaterialApp(
        title: 'Habit Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginWidget(),
        routes: {
          '/home': (context) => HabittrackhomepagewidgetWidget(),
        },
      ),
    );
  }
}
