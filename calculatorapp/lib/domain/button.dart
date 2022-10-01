import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String textButton;
  final buttonTapped;

  const MyButton(
      {super.key,
      this.color,
      this.textColor,
      required this.textButton,
      this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
            color: color,
            child: Center(
              child: Text(
                textButton,
                style: TextStyle(
                  color: textColor,
                  fontSize: 30,
                  fontFamily: "Orbitron",
                ),
              ),
            )),
      ),
    );
  }
}
