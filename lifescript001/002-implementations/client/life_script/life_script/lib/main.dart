import 'package:daily_journal/daily_journal/daily_journal_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
<<<<<<< HEAD
import 'package:goal_setting/index.dart';
=======
import 'package:habittracker/widget/habit_track_homepagewidget.dart';
>>>>>>> d468e6e5b9ca3d77f20dd6d4bd3624e5b4e54bc6
import 'package:life_script/life_script/life_script_widget.dart';
import 'package:perfectday_frontend/PerfectdayWidget.dart';
import 'package:pomodoro_break/home_page/Home_Page_Widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/nav/nav.dart';

///import 'life_script_widget.dart';
//import 'communication_screen.dart';
//import 'daily_journal_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await FlutterFlowTheme.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;

    // Initialize the GoRouter with routes
    _router = GoRouter(
      initialLocation: '/home',
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => LifeScriptWidget(),
        ),
        GoRoute(
          path: '/communication',
          builder: (context, state) => Perfectdayplan1Widget(),
        ),
        GoRoute(
          path: '/dailyjournal',
          builder: (context, state) => DailyJournalWidget(),
        ),
         GoRoute(
<<<<<<< HEAD
          path: '/goalSetting',
          builder: (context, state) => GoalSettingWidget(),
=======
          path: '/pomodoro',
          builder: (context, state) => HomePageWidget(),
        ),
         GoRoute(
          path: '/pomodoro',
          builder: (context, state) => HabittrackhomepageWidget(),
>>>>>>> d468e6e5b9ca3d77f20dd6d4bd3624e5b4e54bc6
        ),
      ],
    );
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LifeScript',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}
