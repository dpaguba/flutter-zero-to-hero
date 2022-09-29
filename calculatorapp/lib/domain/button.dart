import 'package:flutter/material.dart';
import 'package:calculatorapp/global/color_constants.dart';

class MyButton extends StatefulWidget {
  final color;
  final textColor;
  final String textButton;

  const MyButton(
      {super.key, this.color, this.textColor, required this.textButton});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
          color: widget.color,
          child: Center(
            child: Text(
              widget.textButton,
              style: TextStyle(
                color: widget.textColor,
                fontSize: 30,
                fontFamily: "Orbitron",
              ),
            ),
          )),
    );
  }
}
