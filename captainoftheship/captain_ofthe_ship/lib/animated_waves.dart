import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedWaves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/animations/waves.json', // Add a Lottie animation for waves
      fit: BoxFit.cover,
    );
  }
}
