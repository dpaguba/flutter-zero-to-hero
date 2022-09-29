import 'package:calculatorapp/domain/button.dart';
import 'package:calculatorapp/global/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  // TODO: icons for del, divide, multiply.
  // TODO: replace two zero buttons with one big zero button
  List<String> buttons = [
    "C",
    "%",
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
    return Scaffold(
      backgroundColor: BlackWhiteColors.bgGrey,
      body: Column(
        children: [
          Expanded(child: Container()),
          Expanded(
            flex: 2,
            child: Container(
              child: Center(
                  child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                children: buttons
                    .map((btn) => Center(
                            child: Container(
                                child: GridTile(
                                    child: MyButton(
                          textButton: btn,
                          color: (isOperator(btn)
                              ? BlackWhiteColors.btnBlack
                              : BlackWhiteColors.bgGrey),
                          textColor: (isOperator(btn)
                              ? Colors.white
                              : BlackWhiteColors.btnBlack),
                        )))))
                    .toList(),
              )),
            ),
          ),
        ],
      ),
    );
  }
}

bool isOperator(String str) {
  return (str == "C" ||
      str == "DEL" ||
      str == "÷" ||
      str == "%" ||
      str == "x" ||
      str == "-" ||
      str == "+" ||
      str == "=");
}
