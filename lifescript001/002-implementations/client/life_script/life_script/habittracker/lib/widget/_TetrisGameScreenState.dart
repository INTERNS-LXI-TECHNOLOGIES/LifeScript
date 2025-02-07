import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TetrisGameScreen extends StatefulWidget {
  @override
  _TetrisGameScreenState createState() => _TetrisGameScreenState();
}

class _TetrisGameScreenState extends State<TetrisGameScreen> {
  int score = 0;
  int timeLeft = 60;
  List<Offset> piecePositions = [];
  List<GlobalKey> pieceKeys = List.generate(10, (index) => GlobalKey());

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
        startTimer();
      }
    });
  }

  void onPieceDropped(int index, Offset position) {
    setState(() {
      piecePositions[index] = position;
      score += 10;
    });
    HapticFeedback.lightImpact();
    // Add audio feedback here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background with Glassmorphism Effect
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue.withOpacity(0.1), Colors.black],
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          // Tetris Pieces
          for (int i = 0; i < 10; i++)
            Positioned(
              key: pieceKeys[i],
              left: piecePositions.length > i ? piecePositions[i].dx : 100.0 * i,
              top: piecePositions.length > i ? piecePositions[i].dy : 100.0,
              child: Draggable(
                feedback: TetrisPiece(color: Colors.blue),
                childWhenDragging: Opacity(
                  opacity: 0.5,
                  child: TetrisPiece(color: Colors.blue),
                ),
                child: TetrisPiece(color: Colors.blue),
                onDragEnd: (details) {
                  onPieceDropped(i, details.offset);
                },
              ),
            ),
          // Score and Timer
          Positioned(
            top: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Score: $score',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Time: $timeLeft',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TetrisPiece extends StatelessWidget {
  final Color color;

  TetrisPiece({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}