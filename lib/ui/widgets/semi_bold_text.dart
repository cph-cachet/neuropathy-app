import 'package:flutter/material.dart';

/// A [RichText] widget that displays a string with bold and non-bold parts.
///
/// The [text] parameter is the string to be displayed, and the [style] parameter is the style of the text.
/// The [text] parameter must be a HTML string, with the bold parts encapsulated in ```<b>``` tags.
/// The HTML validity is only checked for the bold tags, as this is the only parts this widget considers in display.
///
/// The [style] is consistent across all [RichText] spans, only the [fontWeight] property is changed.
/// The [textAlign] parameter is the alignment of the text.
///
RichText semiBoldText(String text, TextStyle style, TextAlign textAlign) {
  checkHTML(text);

  /// Splits the [text] parameter into a list of strings, alternating between bold and non-bold parts.
  List<String> splitText = text.split(RegExp(r'<b>|<\/b>'));

  /// Keeps track of whether the current part of the string is bold or not.
  /// Since the splitting is between the bold tags, the first part is either non-bold, or empty.
  /// When splitting '<b>...', the first string is '', and the second is '...'.
  /// This is why the initial value is false.
  bool isCurrentBold = false;

  List<TextSpan> semiBoldSplitText = [];
  for (String t in splitText) {
    semiBoldSplitText.add(isCurrentBold
        ? TextSpan(text: t, style: style.copyWith(fontWeight: FontWeight.bold))
        : TextSpan(text: t, style: style));
    isCurrentBold = !isCurrentBold;
  }

  return RichText(
    text: TextSpan(children: semiBoldSplitText),
    textAlign: textAlign,
  );
}

/// Checks if the [text] parameter is a valid HTML string (```<b>``` opening and closing tags only).
void checkHTML(String text) {
  // Only checks proper incapsulation
  RegExp exp = RegExp(r'<b>.*?<\/b>');
  int boldCount = exp.allMatches(text).length;
  int openCount = '<b>'.allMatches(text).length;
  int closeCount = '</b>'.allMatches(text).length;

  if ((boldCount != openCount) | (boldCount != closeCount)) {
    throw FormatException('String "$text" contains invalid HTML');
  }
}
