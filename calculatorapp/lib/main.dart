import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:calculatorapp/screens/calculator.dart';

bool darkMode = false;

final myProvider = StateProvider(((ref) {
  return darkMode;
}));

void main(List<String> args) {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Orbitron"),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Calculator",
            style: TextStyle(color: Colors.black),
          ),
          // actions: [
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Platform.isAndroid
          //           ? Switch(
          //               onChanged: (bool value) {
          //                 darkMode = value;
          //                 print("Switched1 $value");
          //               },
          //               value: darkMode,
          //             )
          //           : CupertinoSwitch(
          //               onChanged: (bool value) {
          //                 darkMode = value;
          //                 print("Switched2 $value");
          //               },
          //               value: darkMode,
          //             ),
          //     ],
          //   ),
          // ],
          backgroundColor: Colors.grey[300],
          elevation: 0,
        ),
        body: Calculator(),
      ),
    );
  }
}
