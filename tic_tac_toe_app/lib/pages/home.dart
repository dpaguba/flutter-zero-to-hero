import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> displayExOh = List.generate(9, (index) => "");
  bool ohTurn = true;
  int filledBoxes = 0;
  int ohScore = 0;
  int exScore = 0;

  void _clearBoard() {
    setState(() {
      displayExOh = List.generate(9, (index) => "");
      filledBoxes = 0;
    });
  }

  void _increaseScore(bool isWon) {
    setState(() {
      if (isWon) {
        ohTurn ? exScore += 1 : ohScore += 1;
      }
    });
  }

  void _showGameEndDialog(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: winner != "draw"
              ? Text("Winner is: $winner!")
              : const Text("It's a draw!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
              child: const Text("Play Again!"),
            ),
          ],
        );
      },
    );
  }

  void _checkWinner() {
    if ((displayExOh[0] == displayExOh[1] &&
            displayExOh[0] == displayExOh[2] &&
            displayExOh[0] != "") ||
        (displayExOh[3] == displayExOh[4] &&
            displayExOh[3] == displayExOh[5] &&
            displayExOh[3] != "") ||
        (displayExOh[6] == displayExOh[7] &&
            displayExOh[6] == displayExOh[8] &&
            displayExOh[6] != "") ||
        (displayExOh[0] == displayExOh[3] &&
            displayExOh[0] == displayExOh[6] &&
            displayExOh[0] != "") ||
        (displayExOh[1] == displayExOh[4] &&
            displayExOh[1] == displayExOh[7] &&
            displayExOh[1] != "") ||
        (displayExOh[2] == displayExOh[5] &&
            displayExOh[2] == displayExOh[8] &&
            displayExOh[2] != "") ||
        (displayExOh[2] == displayExOh[4] &&
            displayExOh[2] == displayExOh[6] &&
            displayExOh[2] != "") ||
        (displayExOh[0] == displayExOh[4] &&
            displayExOh[0] == displayExOh[8] &&
            displayExOh[0] != "")) {
      _increaseScore(true);
      _showGameEndDialog(ohTurn ? "X" : "O");
    } else if (filledBoxes == displayExOh.length) {
      _showGameEndDialog("draw");
    }
  }

  bool _isTapped(int index) {
    return displayExOh[index] == "";
  }

  void _tapped(int index) {
    setState(() {
      if (_isTapped(index)) {
        if (ohTurn) {
          displayExOh[index] = "O";
        } else {
          displayExOh[index] = "X";
        }
        ohTurn = !ohTurn;
        filledBoxes += 1;
        _checkWinner();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Player X",
                          style: textStyle,
                        ),
                        Text(
                          exScore.toString(),
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Player O",
                          style: textStyle,
                        ),
                        Text(
                          ohScore.toString(),
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor),
                        ),
                        child: Center(
                          child: Text(
                            displayExOh[index],
                            style: textStyle,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
