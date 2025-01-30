import 'dart:ui';

import 'package:communication/widgets/tongue_twister.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linguo Glass',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final tongueTwisterImage =
      "https://i.pinimg.com/736x/bf/9b/57/bf9b57dcd193309d8bce1ad8a1cefb0d.jpg";
  final dailyLessonImage =
      "https://i.pinimg.com/736x/bf/9b/57/bf9b57dcd193309d8bce1ad8a1cefb0d.jpg";
  final aiCoachImage =
      "https://i.pinimg.com/736x/bf/9b/57/bf9b57dcd193309d8bce1ad8a1cefb0d.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        height: 700,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2A2A2A),
              Color(0xFF1A1A1A),
              Color(0xFF0A0A0A),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                'Language Mastery',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  _GlassCard(
                    imageUrl: tongueTwisterImage,
                    title: 'Tongue Twister',
                    description:
                        'Master pronunciation with challenging phrases',
                    icon: Icons.record_voice_over, // Unique icon
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TongueTwister()));
                      print("Tongue Twister Started");
                    },
                  ),
                  SizedBox(width: 20),
                  _GlassCard(
                    imageUrl: dailyLessonImage,
                    title: 'Daily Lessons',
                    description: 'Personalized learning journey',
                    icon: Icons.menu_book, // Unique icon
                    onPressed: () {
                      print("Daily Lessons Started");
                    },
                  ),
                  SizedBox(width: 20),
                  _GlassCard(
                    imageUrl: aiCoachImage,
                    title: 'AI Coach',
                    description: 'Real-time speech analysis',
                    icon: Icons.smart_toy, // Unique icon
                    onPressed: () {
                      print("AI Coach Started");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final IconData icon; // New Icon parameter
  final VoidCallback onPressed;

  const _GlassCard({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.icon, // Accepts an icon
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    return progress == null
                        ? child
                        : Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.black.withOpacity(0.3),
                      child: Center(
                        child: Icon(Icons.broken_image, color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 30,
                        offset: Offset(5, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon,
                            size: 50,
                            color:
                                Colors.white), // Different icon for each card
                        SizedBox(height: 10),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: onPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            'Start',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
