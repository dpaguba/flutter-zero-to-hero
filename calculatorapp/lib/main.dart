import 'package:flutter/material.dart';
import 'package:calculatorapp/screens/calculator.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Orbitron"),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Calculator",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.grey[300],
          elevation: 0,
        ),
        body: const Calculator(),
      ),
    );
  }
}
