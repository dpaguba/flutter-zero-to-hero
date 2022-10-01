import 'package:calculatorapp/domain/button.dart';
import 'package:calculatorapp/global/color_constants.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String first = "";
  String second = "";
  String operator = "";
  double? result;

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

  String del(String str) {
    return (str.isEmpty) ? "" : str.substring(0, str.length - 1);
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
        result = a / b;
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                width: screenWidth - 40,
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(4, 4),
                          blurRadius: 15,
                          spreadRadius: 1,
                          inset: true,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 15,
                          spreadRadius: 1,
                          inset: true,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                first,
                                style: const TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                              Text(
                                operator,
                                style: const TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                              Text(
                                second,
                                style: const TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            displayResult(),
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: isOperator(btn)
                                    ? [
                                        const BoxShadow(
                                          color: Colors.black87,
                                          offset: Offset(4, 4),
                                          blurRadius: 15,
                                          spreadRadius: 1,
                                        ),
                                        const BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(-4, -4),
                                          blurRadius: 15,
                                          spreadRadius: 1,
                                        ),
                                      ]
                                    : [
                                        const BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(4, 4),
                                          blurRadius: 15,
                                          spreadRadius: 1,
                                        ),
                                        const BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(-4, -4),
                                          blurRadius: 15,
                                          spreadRadius: 1,
                                        ),
                                      ],
                              ),
                              child: MyButton(
                                buttonTapped: () {
                                  setState(() {
                                    switch (btn) {
                                      case "C":
                                        clearAll();
                                        break;

                                      case "%":
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
                                          if (isOperatorPressed() &&
                                              first.isNotEmpty) {
                                            second += btn;
                                          } else {
                                            first += btn;
                                          }
                                        } else {
                                          operator = (btn != "=" &&
                                                  btn != "DEL" &&
                                                  btn != "C" &&
                                                  btn != "±")
                                              ? btn
                                              : operator;
                                        }
                                        break;
                                    }
                                  });
                                },
                                textButton: btn,
                                color: (isOperator(btn)
                                    ? BlackWhiteColors.btnBlack
                                    : BlackWhiteColors.bgGrey),
                                textColor: (isOperator(btn)
                                    ? Colors.white
                                    : BlackWhiteColors.btnBlack),
                              ),
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
}
