import 'package:flutter/material.dart';

void main() {
  runApp(TetrisGame());
}

class TetrisGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TetrisGameScreen(),
    );
  }
}

class TetrisGameScreen extends StatefulWidget {
  @override
  _TetrisGameScreenState createState() => _TetrisGameScreenState();
}

class _TetrisGameScreenState extends State<TetrisGameScreen> {
  static const int rows = 10;
  static const int cols = 10;
  List<List<int>> grid = List.generate(rows, (i) => List.filled(cols, 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tetris Puzzle UI")),
      body: Column(
        children: [
          Expanded(flex: 3, child: _buildDraggablePieces()),
          Expanded(flex: 7, child: _buildGrid()),
        ],
      ),
    );
  }

  Widget _buildDraggablePieces() {
    List<List<int>> tetrominoL = [
      [1, 0],
      [1, 0],
      [1, 1],
    ];

    return Center(
      child: Draggable<List<List<int>>>(
        data: tetrominoL,
        feedback: _buildTetromino(tetrominoL, Colors.blue),
        childWhenDragging: Opacity(
          opacity: 0.5,
          child: _buildTetromino(tetrominoL, Colors.blue),
        ),
        child: _buildTetromino(tetrominoL, Colors.blue),
      ),
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
      ),
      itemBuilder: (context, index) {
        int row = index ~/ cols;
        int col = index % cols;
        return Container(
          margin: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: grid[row][col] == 1 ? Colors.grey : Colors.white,
            border: Border.all(color: Colors.black, width: 0.5),
          ),
        );
      },
      itemCount: rows * cols,
    );
  }

  Widget _buildTetromino(List<List<int>> shape, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: shape.map((row) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: row.map((cell) {
            return Container(
              width: 20,
              height: 20,
              color: cell == 1 ? color : Colors.transparent,
              margin: EdgeInsets.all(1),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
