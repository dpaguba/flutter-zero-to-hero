import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayExOh = '';

  void _tapped() {
    setState(() {
      displayExOh = '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: _tapped,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                ),
                child: Center(
                  child: Text(
                    displayExOh,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
