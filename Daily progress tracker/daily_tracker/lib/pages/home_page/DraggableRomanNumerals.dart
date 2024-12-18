import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class DraggableRomanNumerals extends StatefulWidget {
  @override
  _DraggableRomanNumeralsState createState() => _DraggableRomanNumeralsState();
}

class _DraggableRomanNumeralsState extends State<DraggableRomanNumerals> {
  final Map<String, int> boxCounts = {
    'I': 0,
    'II': 0,
    'III': 0,
    'IV': 0,
  };

  bool playPrimaryAnimation = false;
  bool playEqualCountsAnimation = false;
  bool playUnequalCountsAnimation = false;
  bool isCompleteButtonDisabled = false;

  void resetCounts() {
    setState(() {
      boxCounts.updateAll((key, value) => 0);
      playPrimaryAnimation = false;
      playEqualCountsAnimation = false;
      playUnequalCountsAnimation = false;
      isCompleteButtonDisabled = false;
    });
  }

  bool areCountsEqual() {
    int firstValue = boxCounts.values.first;
    return boxCounts.values.every((count) => count == firstValue);
  }

  void completeAction() {
    setState(() {
      playPrimaryAnimation = true;
      isCompleteButtonDisabled = true;
    });

    // Stop primary animation after 5 seconds and evaluate conditions
    Timer(Duration(seconds: 5), () {
      setState(() {
        playPrimaryAnimation = false;

        if (areCountsEqual()) {
          playEqualCountsAnimation = true;
        } else {
          playUnequalCountsAnimation = true;
        }

        // Stop condition-based animations after 5 seconds
        Timer(Duration(seconds: 5), () {
          setState(() {
            playEqualCountsAnimation = false;
            playUnequalCountsAnimation = false;
            isCompleteButtonDisabled = false;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draggable Roman Numerals'),
      ),
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: boxCounts.keys.map((numeral) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Draggable<String>(
                  data: numeral,
                  feedback: Container(
                    width: 80,
                    height: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.lightBlueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      numeral,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.5,
                    child: _buildRomanBox(numeral),
                  ),
                  child: _buildRomanBox(numeral),
                ),
              );
            }).toList(),
          ),
          Container(
            width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DragTarget<String>(
                  onAccept: (data) {
                    setState(() {
                      boxCounts[data] = (boxCounts[data] ?? 0) + 1;
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      width: 220,
                      height: 180,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.pinkAccent, Colors.orangeAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black87, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(3, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Drop Here',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Counts:',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                          ...boxCounts.entries.map((entry) {
                            return Text(
                              '${entry.key}: ${entry.value}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isCompleteButtonDisabled ? null : completeAction,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text('Complete'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: resetCounts,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text('Reset'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (playPrimaryAnimation)
                  Lottie.asset(
                    'assets/animations/Analysing.json',
                    height: 250,
                  ),
                if (playEqualCountsAnimation)
                  Lottie.asset(
                    'assets/animations/Time.json',
                    height: 250,
                  ),
                if (playUnequalCountsAnimation)
                  Lottie.asset(
                    'assets/animations/DashBoard.json',
                    height: 250,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRomanBox(String numeral) {
    return Container(
      width: 80,
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.lightBlueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Text(
        numeral,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


