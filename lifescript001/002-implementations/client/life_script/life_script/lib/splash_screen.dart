import 'dart:async';
import 'dart:math';
import 'package:daily_journal/daily_journal/daily_journal_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:goal_setting/goal_setting/goal_setting_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_script/index.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:perfectday_frontend/PerfectdayWidget.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  final List<Map<String, dynamic>> _pages = [
    {
      "title": "Welcome to HumAIn",
      "subtitle": "Reprogram Your Mind. Redefine Your Reality.",
      "icon": Icons.rocket_launch,
    },
    {
      "title": "AI to program YOU and your Hormones",
      "subtitle": "This App helps program YOU, thru your Hormones",
      "icon": Icons.auto_awesome,
    },
    {
      "title": "You are in control",
      "subtitle": "Remote control Your Mind & Body. Achieve Peak Performance.",
      "icon": Icons.touch_app,
      "showButton": false,
    },
    {
      "title": "Fasten your seatbelt",
      "subtitle": "Your transformation starts now.",
      "icon": Icons.touch_app,
      "showButton": true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoPageSwitch();
  }

  void _startAutoPageSwitch() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < _pages.length - 1) {
        _currentPage++;
      } else {
        timer.cancel(); // Stop auto-switching after the last page
      }
      if (mounted) {
        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 3D Model in Background
          Positioned.fromRect(
            rect: Rect.fromLTWH(100, 100, MediaQuery.of(context).size.width - 200, MediaQuery.of(context).size.height - 200),
            child: ModelViewer(
              src: 'assets/human.glb',
              alt: "A 3D model",
              autoRotate: true,
              cameraControls: false,
              backgroundColor: Colors.black,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder(
                  duration: Duration(seconds: 10),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: child,
                    );
                  },
                  child: Text(
                    "HumAIn",
                    style: GoogleFonts.poppins(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Swiper(
            itemCount: 4,
            autoplay: true,
            duration: 800,
            loop: false,
            itemBuilder: (context, index) {
              return buildPage(
                _pages[index]["title"],
                _pages[index]["subtitle"],
                _pages[index]["icon"],
                showButton: _pages[index]["showButton"] ?? false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildPage(String title, String subtitle, IconData icon, {bool showButton = false}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black.withOpacity(0.7), Colors.transparent],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: Colors.white),
          const SizedBox(height: 20),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          if (showButton)
            ElevatedButton(
              onPressed: () {
                print("Get Started");
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text("Get Started", style: GoogleFonts.poppins(fontSize: 16, color: Colors.white70)),
            ),
        ],
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  final int index;
  const SplashContent({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    List<String> texts = [
      "Reprogram Your Mind. Redefine Your Reality.",
      "Biology Meets Code. You're the Programmer.",
      "Align Your Mind & Body. Achieve Peak Performance.",
      "Your transformation starts now.",
    ];

    return Container(
      color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              texts[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [Shadow(blurRadius: 5, color: Colors.blueAccent)],
              ),
            ),
            if (index == 3)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Perfectdayplan1Widget()),
                    );
                  },
                  child: const Text("Get Started"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Positioned.fromRect(
              rect: Rect.fromLTWH(100, 100, MediaQuery.of(context).size.width - 200, MediaQuery.of(context).size.height - 200),
              child: ModelViewer(
                src: 'assets/human.glb',
                alt: "A 3D model",
                autoRotate: true,
                cameraControls: false,
                backgroundColor: Colors.black,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder(
                    duration: Duration(seconds: 10),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: child,
                      );
                    },
                    child: Text(
                      "HumAIn",
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: Stack(
                  children: List.generate(5, (index) {
                    double angle = (index * 2 * pi) / 5; // Spread buttons in a circle
                    double radius = 120; // Distance from center
                    return Positioned(
                      left: 150 + radius * cos(angle) - 25,
                      top: 150 + radius * sin(angle) - 25,
                      child: FloatingActionButton(
                        onPressed: () {
                          // Navigate to the corresponding widget page based on the index
                          switch (index) {
                            case 0:
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Perfectdayplan1Widget()),
                              );
                              break;
                            case 1:
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GoalSettingWidget()),
                              );
                              break;
                            case 2:
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DailyJournalWidget()),
                              );
                              break;
                            case 3:
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomePageWidget()),
                              );
                              break;
                            case 4:
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RefreshScreen()),
                              );
                              break;
                          }
                        },
                        backgroundColor: Colors.primaries[index % Colors.primaries.length],
                        child: Icon([Icons.rotate_left, Icons.zoom_in, Icons.zoom_out, Icons.model_training, Icons.refresh][index]),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





class ZoomOutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Zoom Out Screen")),
      body: Center(child: Text("This is the Zoom Out Screen")),
    );
  }
}



class RefreshScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Refresh Screen")),
      body: Center(child: Text("This is the Refresh Screen")),
    );
  }
}

Widget loadModel() {
  return ModelViewer(
    backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
    src: 'assets/human.glb',
    alt: 'A 3D model of an astronaut',
    ar: true,
    arModes: ['scene-viewer', 'webxr', 'quick-look'],
    autoRotate: true,
    disableZoom: true,
  );
}