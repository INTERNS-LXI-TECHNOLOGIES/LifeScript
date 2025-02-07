import 'package:flutter/material.dart';

class TetrisGameScreen extends StatefulWidget {
  const TetrisGameScreen({super.key});

  @override
  State<TetrisGameScreen> createState() => _TetrisGameScreenState();
}

class _TetrisGameScreenState extends State<TetrisGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Pure blue background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tetris Board
            TetrisBoard(),
            // Draggable Pieces
            DraggablePieces(),
          ],
        ),
      ),
    );
  }
}

class TetrisBoard extends StatelessWidget {
  final int rows = 2; // Number of rows in the Tetris grid
  final int columns = 10; // Number of columns in the Tetris grid

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.black, // Pure black background for the board
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
        ),
        itemCount: rows * columns,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: Colors.grey[800], // Default cell color
              border: Border.all(color: Colors.white, width: 0.5),
            ),
          );
        },
      ),
    );
  }
}

class TetrisPiece extends StatelessWidget {
  final List<List<int>> shape; // 2D array representing the piece shape
  final Color color;

  const TetrisPiece({super.key, required this.shape, required this.color});

  @override
  Widget build(BuildContext context) {
    return Draggable<List<List<int>>>(
      data: shape,
      feedback: Material(
        color: Colors.transparent,
        child: Container(
          width: shape[0].length * 30.0,
          height: shape.length * 30.0,
          decoration: BoxDecoration(
            color: color.withOpacity(0.7),
          ),
        ),
      ),
      childWhenDragging: Container(), // Hide the original piece while dragging
      child: Container(
        width: shape[0].length * 30.0,
        height: shape.length * 30.0,
        decoration: BoxDecoration(
          color: color,
        ),
      ),
    );
  }
}

class DraggablePieces extends StatelessWidget {
  final List<TetrisPiece> pieces = [
    TetrisPiece(
      shape: [
        [1, 1],
        [1, 1],
      ],
      color: Colors.yellow, // O piece
    ),
    TetrisPiece(
      shape: [
        [0, 1, 0],
        [1, 1, 1],
      ],
      color: Colors.purple, // T piece
    ),
    // Add more pieces (L, J, S, Z, I) here
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: pieces.map((piece) => piece).toList(),
    );
  }
}