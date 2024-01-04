import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tetris/piece.dart';
import 'package:flutter_tetris/pixel.dart';
import 'package:flutter_tetris/values.dart';

// create game board list

List<List<Terromino?>> gameBoard =
    List.generate(colLen, (i) => List.generate(rowLen, (j) => null));

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece currentPiece = Piece(type: Terromino.L);

  // current score
  int currentScore = 0;

  // is game over
  bool gameOver = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();

    Duration frameRate = const Duration(milliseconds: 800);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        // clear line
        clearLines();
        //check landing collison
        checkLanding();

        // if game is over or not
        if (gameOver) {
          timer.cancel();
          showGameOverDialog();
        }
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Game Over"),
        content: Text("Your score is $currentScore"),
        actions: [
          TextButton(
              onPressed: () {
                resetGame();
                Navigator.pop(context);
              },
              child: Text("Replay"))
        ],
      ),
    );
  }

  void resetGame() {
    // clear board
    gameBoard =
        List.generate(colLen, (i) => List.generate(rowLen, (j) => null));

    gameOver = false;
    currentScore = 0;
    // create new piece
    createNewPiece();
    // start the game
    startGame();
  }

  // COLLISION DETECTION
  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLen).floor();
      int col = currentPiece.position[i] % rowLen;

      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      //
      if (row >= colLen || col < 0 || col >= rowLen) {
        return true;
      }

      if (row >= 0 && col > 0) {
        if (gameBoard[row][col] != null) {
          return true;
        }
      }
    }

    return false;
  }

  //
  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLen).floor();
        int col = (currentPiece.position[i] % rowLen);
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      createNewPiece();
    }
  }

  void createNewPiece() {
    // random opiece create
    Random rand = Random();

    Terromino randomType =
        Terromino.values[rand.nextInt(Terromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    //...
    if (isGameOver()) {
      gameOver = true;
    }
  }

  // three moving methods

  void goLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void goRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  // clear if reached if one line or lines are completed
  void clearLines() {
    int linesCleared = 0;

    for (int row = colLen - 1; row >= 0; row--) {
      bool rowIsFull = true;

      for (int col = 0; col < rowLen; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        gameBoard[0] = List.generate(rowLen, (index) => null);

        // Update the positions of the falling piece
        for (int i = 0; i < currentPiece.position.length; i++) {
          currentPiece.position[i] += rowLen;
        }

        linesCleared++;
      }
    }

    if (linesCleared > 0) {
      // Update score for each cleared line
      currentScore++;
    }
  }

  // game over

  bool isGameOver() {
    for (int col = 0; col < rowLen; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: colLen * rowLen,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowLen),
              itemBuilder: (context, index) {
                int row = (index / rowLen).floor();
                int col = index % rowLen;
                if (currentPiece.position.contains(index)) {
                  return Pixel(
                    color: Colors.yellow,
                  );
                } else if (gameBoard[row][col] != null) {
                  final Terromino? terrominoType = gameBoard[row][col];

                  return Pixel(color: Colors.pink);
                } else {
                  return Pixel(
                    color: Colors.grey[900],
                  );
                }
              },
            ),
          ),

          // scores display
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Score: $currentScore",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          // Game Controls

          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: goLeft,
                  icon: Icon(Icons.arrow_back_ios_new),
                  color: Colors.white,
                ),
                IconButton(
                    onPressed: rotatePiece,
                    icon: Icon(Icons.rotate_right),
                    color: Colors.white),
                IconButton(
                    onPressed: goRight,
                    icon: Icon(Icons.arrow_forward_ios),
                    color: Colors.white),
              ],
            ),
          )
        ],
      ),
    );
  }
}
