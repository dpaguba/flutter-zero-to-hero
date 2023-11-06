import 'package:calculatorapp/screens/calcScreen.dart';
import 'package:calculatorapp/domain/whiteButton.dart';
import 'package:calculatorapp/global/color_constants.dart';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/blackButton.dart';
import '../domain/pressedBlackButton.dart';
import '../domain/pressedWhiteButton.dart';

class Calculator extends ConsumerStatefulWidget {
  // final bool darkmode;

  const Calculator({Key? key}) : super(key: key);

  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends ConsumerState<Calculator> {
  // Variables

  String first = "";
  String second = "";
  String operator = "";
  double? result;

  List<bool> buttonPressed = List<bool>.filled(20, false, growable: false);

  List<String> buttons = [
    "C",
    "±",
    "DEL",
    "÷",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "00",
    "0",
    ".",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorConst.wBackground,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                width: screenWidth - 40,
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: CalculatorScreen(
                    a: first,
                    b: second,
                    operator: operator,
                    result: displayResult()),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                children: buttons
                    .map(
                      (btn) => Center(
                        child: GridTile(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 20, left: 10, right: 10),
                            child: AnimatedContainer(
                              duration: const Duration(
                                milliseconds: 200,
                              ),
                              child: isOperator(btn)
                                  ? (isPressed(btn)
                                      ? PressedBlackButton(
                                          buttonTapped: () {
                                            interactWithUI(btn);
                                          },
                                          textButton: btn,
                                        )
                                      : BlackButton(
                                          buttonTapped: () {
                                            interactWithUI(btn);
                                          },
                                          textButton: btn,
                                        ))
                                  : (isPressed(btn)
                                      ? PressedWhiteButton(
                                          buttonTapped: () {
                                            interactWithUI(btn);
                                          },
                                          textButton: btn,
                                        )
                                      : WhiteButton(
                                          buttonTapped: () {
                                            interactWithUI(btn);
                                          },
                                          textButton: btn,
                                        )),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Functions

  bool isOperator(String str) {
    return (str == "C" ||
        str == "DEL" ||
        str == "÷" ||
        str == "±" ||
        str == "x" ||
        str == "-" ||
        str == "+" ||
        str == "=");
  }

  bool isOperatorPressed() {
    return operator != "";
  }

  void changePressedValue(String str) {
    buttonPressed = List<bool>.filled(20, false, growable: false);
    _checkLength();
    int index = buttons.indexOf(str);
    buttonPressed[index] = true;
  }

  bool isPressed(String btn) {
    return buttonPressed[buttons.indexOf(btn)];
  }

  void clearAll() {
    first = "";
    second = "";
    operator = "";
    result = null;
  }

  void delete() {
    if (second.isNotEmpty) {
      second = second.substring(0, second.length - 1);
    } else if (operator.isNotEmpty) {
      operator = "";
    } else if (first.isNotEmpty) {
      first = first.substring(0, first.length - 1);
    }

    if (result != null) {
      return result = null;
    }
  }

  String changeSign(String str) {
    double num = double.parse(str);
    num = num + (-num * 2);
    return num.toString();
  }

  calculate() {
    double a = double.parse(first);
    double b = double.parse(second);

    switch (operator) {
      case "÷":
        clearAll();
        result = (a ~/ b).toDouble();
        break;

      case "x":
        clearAll();
        result = a * b;
        break;

      case "+":
        clearAll();
        result = a + b;
        break;

      case "-":
        clearAll();
        result = a - b;
        break;
    }
  }

  String displayResult() {
    if (result == null ||
        (result != null &&
            (first.isNotEmpty || second.isNotEmpty || operator.isNotEmpty))) {
      return "";
    } else {
      return result.toString();
    }
  }

  void _checkLength() {
    if ((first.length + second.length + operator.length) >= 12) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Length of this expression is too long!"),
            actions: [
              Center(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      clearAll();
                      buttonPressed =
                          List<bool>.filled(20, false, growable: false);
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Try Again",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void interactWithUI(String btn) {
    setState(() {
      changePressedValue(btn);
      switch (btn) {
        case "C":
          clearAll();
          break;

        case "DEL":
          delete();
          break;

        case "±":
          if (second.isEmpty) {
            first = changeSign(first);
          } else {
            second = changeSign(second);
          }
          break;

        case "=":
          calculate();
          break;

        default:
          if (!isOperator(btn)) {
            if (isOperatorPressed() && first.isNotEmpty) {
              second += btn;
            } else {
              first += btn;
            }
          } else {
            operator = (btn != "=" && btn != "DEL" && btn != "C" && btn != "±")
                ? btn
                : operator;
          }
          break;
      }
    });
  }
}
