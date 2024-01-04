import 'package:flutter_tetris/board.dart';
import 'package:flutter_tetris/values.dart';

class Piece {
  Terromino type;

  Piece({required this.type});

  List<int> position = [];

  void initializePiece() {
    switch (type) {
      case Terromino.L:
        position = [-26, -16, -6, -5];
        break;
      case Terromino.J:
        position = [-25, -15, -5, -6];
        break;
      case Terromino.I:
        position = [-4, -5, -6, -7];
        break;
      case Terromino.O:
        position = [-15, -16, -5, -6];
        break;
      case Terromino.S:
        position = [-15, -14, -6, -5];
        break;
      case Terromino.Z:
        position = [-17, -16, -6, -5];
        break;
      case Terromino.T:
        position = [-26, -16, -6, -15];
        break;
      default:
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLen;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  // rotation
  int rotateState = 1;
  void rotatePiece() {
    List<int> newPosition = [];

    switch (type) {
      case Terromino.L:
        switch (rotateState) {
          case 0:
            newPosition = [
              position[1] - rowLen,
              position[1],
              position[1] + rowLen,
              position[1] + rowLen + 1
            ];
            position = newPosition;
            rotateState = (rotateState + 1) % 4;

            break;
          case 1:
            newPosition = [
              position[1] - rowLen,
              position[1],
              position[1] + rowLen,
              position[1] + rowLen + 1
            ];

            position = newPosition;
            rotateState = (rotateState + 1) % 4;

            break;
          case 2:
            newPosition = [
              position[1] - rowLen,
              position[1],
              position[1] + rowLen,
              position[1] + rowLen + 1
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] - rowLen,
              position[1],
              position[1] + rowLen,
              position[1] + rowLen + 1
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          default:
        }
      default:
    }
  }

  // check if rotation will go wrong
  bool positionIsValid(int position) {
    int row = (position / rowLen).floor();
    int col = position % rowLen;

    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }
    return true;
  }

  // check if piece is valid position
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;
    for (int pos in piecePosition) {
      if (!positionIsValid(pos)) {
        return false;
      }

      // get the col
      int col = pos % rowLen;

      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLen - 1) {
        lastColOccupied = true;
      }
    }
    // if both are true, they are through the wall

    return !(firstColOccupied && lastColOccupied);
  }
}
