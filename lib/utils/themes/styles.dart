import 'package:flutter/material.dart';

/// A class that holds the custom styles for the app.
class Styles {
  static ButtonStyle roundedButtonStyle = ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18.0),
  )));
}
