import 'package:flutter/material.dart';

class TetrisGame extends StatefulWidget {
  @override
  _TetrisGameState createState() => _TetrisGameState();
}

class _TetrisGameState extends State<TetrisGame> {
  // Define the grid dimensions
  final List<List<int>> grid = List.generate(10, (_) => List.filled(10, 0));

  // Define some Tetris pieces with different shapes and colors
  final List<TetrisPiece> tetrisPieces = [
    TetrisPiece(shape: [[1, 1], [1, 1]], color: Colors.blue), // O-shaped
    TetrisPiece(shape: [[1, 1, 1], [0, 1, 0]], color: Colors.green), // T-shaped
    TetrisPiece(shape: [[1, 0, 0], [1, 1, 1]], color: Colors.red), // L-shaped
    TetrisPiece(shape: [[0, 0, 1], [1, 1, 1]], color: Colors.orange), // J-shaped
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tetris Game')),
      body: Column(
        children: [
          // Draggable pieces section
          Container(
            padding: EdgeInsets.all(10),
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tetrisPieces.length,
              itemBuilder: (context, index) {
                return Draggable<TetrisPiece>(
                  data: tetrisPieces[index],
                  feedback: Material(
                    color: Colors.transparent,
                    child: tetrisPieces[index], // Visual feedback while dragging
                  ),
                  child: tetrisPieces[index], // Original piece
                  childWhenDragging: Container(), // Placeholder when dragging
                );
              },
            ),
          ),

          // Game board grid section
          Expanded(
            child: GridView.builder(
              itemCount: 100, // 10x10 grid
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 10,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemBuilder: (context, index) {
                final row = index ~/ 10;
                final col = index % 10;

                return DragTarget<TetrisPiece>(
                  onAccept: (piece) {
                    setState(() {
                      _lockPiece(piece, row, col);
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      decoration: BoxDecoration(
                        color: grid[row][col] == 1
                            ? _getPieceColor(row, col)
                            : Colors.transparent,
                        border: Border.all(color: Colors.black.withOpacity(0.5)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Lock the piece into the grid
  void _lockPiece(TetrisPiece piece, int row, int col) {
    for (int r = 0; r < piece.shape.length; r++) {
      for (int c = 0; c < piece.shape[r].length; c++) {
        if (piece.shape[r][c] == 1) {
          final targetRow = row + r;
          final targetCol = col + c;
          if (targetRow < 10 && targetCol < 10) {
            grid[targetRow][targetCol] = 1;
          }
        }
      }
    }
  }

  // Get color for a locked piece
  Color _getPieceColor(int row, int col) {
    // Return a color based on the piece (you can customize this logic)
    if (grid[row][col] == 1) {
      return Colors.blue; // Color for locked pieces
    }
    return Colors.transparent;
  }
}

// Custom widget for a Tetris piece
class TetrisPiece extends StatelessWidget {
  final List<List<int>> shape;
  final Color color;

  TetrisPiece({required this.shape, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemCount: shape.length * shape[0].length,
        itemBuilder: (context, index) {
          final row = index ~/ shape[0].length;
          final col = index % shape[0].length;
          return Container(
            decoration: BoxDecoration(
              color: shape[row][col] == 1 ? color : Colors.transparent,
            ),
          );
        },
      ),
    );
  }
}