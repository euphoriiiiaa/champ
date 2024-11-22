import 'dart:ui';

import 'package:flutter/material.dart';

TextStyle myTextStyle(
    double fontSize, Color color, TextDecoration? decoration) {
  var myTextStyle = TextStyle(
    decoration: decoration,
    fontSize: fontSize,
    fontFamily: "New Peninim MT",
    fontWeight: FontWeight.normal,
    color: color,
  );
  return myTextStyle;
}
