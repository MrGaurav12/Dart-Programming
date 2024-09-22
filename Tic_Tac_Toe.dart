import 'dart:io';

void main() {
  
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ' '));
  String currentPlayer = 'X';
  bool gameWon = false;
  int moves = 0;

  printBoard(board);

  while (!gameWon && moves < 9) {
    print("Player $currentPlayer's turn. Enter row and column (1-3):");
    int row = int.parse(stdin.readLineSync()!) - 1;
    int col = int.parse(stdin.readLineSync()!) - 1;

    if (board[row][col] == ' ') {
      board[row][col] = currentPlayer;
      moves++;
      gameWon = checkWinner(board, currentPlayer);

      if (gameWon) {
        printBoard(board);
        print("Player $currentPlayer wins!");
      } else if (moves == 9) {
        printBoard(board);
        print("It's a draw!");
      } else {
        currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
        printBoard(board);
      }
    } else {
      print("Invalid move, cell already occupied. Try again.");
    }
  }
}

void printBoard(List<List<String>> board) {
  for (var row in board) {
    print(row.join('|'));
    print('- ' * 5);
  }
}

bool checkWinner(List<List<String>> board, String player) {
 
  for (int i = 0; i < 3; i++) {
    if (board[i].every((cell) => cell == player) ||
        [0, 1, 2].every((j) => board[j][i] == player)) { 
      return true;
    }
  }
  if ([0, 1, 2].every((i) => board[i][i] == player) || 
      [0, 1, 2].every((i) => board[i][2 - i] == player)){ 
    return true;
  }
  return false;
}