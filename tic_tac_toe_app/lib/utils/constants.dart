import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color backgroundColor = Color.fromRGBO(
  33,
  33,
  33,
  1,
);

const Color borderColor = Color.fromARGB(
  255,
  97,
  97,
  97,
);

final TextStyle customFontBlack = GoogleFonts.pressStart2p(
  textStyle: const TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    letterSpacing: 3,
  ),
);

final TextStyle customFontWhite = GoogleFonts.pressStart2p(
  textStyle: const TextStyle(
    color: Colors.white,
    letterSpacing: 3,
    fontSize: 15,
  ),
);
