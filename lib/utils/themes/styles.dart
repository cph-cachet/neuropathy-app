import 'package:flutter/material.dart';

class Styles {
  static ButtonStyle roundedButtonStyle = ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18.0),
  )));
}
