

import 'package:flutter/material.dart';

void main() {
  runApp(const ChessApp());
}

class ChessApp extends StatelessWidget {
  const ChessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChessBoard(),
    );
  }
}

class ChessBoard extends StatefulWidget {
  const ChessBoard({super.key});

  @override
  State<ChessBoard> createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  List<List<String>> board = [
    ['♜','♞','♝','♛','♚','♝','♞','♜'],
    ['♟','♟','♟','♟','♟','♟','♟','♟'],
    ['','','','','','','',''],
    ['','','','','','','',''],
    ['','','','','','','',''],
    ['','','','','','','',''],
    ['♙','♙','♙','♙','♙','♙','♙','♙'],
    ['♖','♘','♗','♕','♔','♗','♘','♖'],
  ];

  int? selectedRow;
  int? selectedCol;

  void onTap(int row, int col) {
    setState(() {
      if (selectedRow == null) {
        if (board[row][col].isNotEmpty) {
          selectedRow = row;
          selectedCol = col;
        }
      } else {
        board[row][col] = board[selectedRow!][selectedCol!];
        board[selectedRow!][selectedCol!] = '';

        selectedRow = null;
        selectedCol = null;
      }
    });
  }

  bool isSelected(int r, int c) =>
      selectedRow == r && selectedCol == c;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic Flutter Chess"),
        centerTitle: true,
      ),
      body: AspectRatio(
        aspectRatio: 1,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 64,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
          ),
          itemBuilder: (context, index) {
            final row = index ~/ 8;
            final col = index % 8;

            final isWhite = (row + col) % 2 == 0;

            Color color = isWhite
                ? Colors.brown.shade200
                : Colors.brown.shade700;

            if (isSelected(row, col)) {
              color = Colors.green;
            }

            return GestureDetector(
              onTap: () => onTap(row, col),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: Colors.black12),
                ),
                child: Center(
                  child: Text(
                    board[row][col],
                    style: const TextStyle(fontSize: 34),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
