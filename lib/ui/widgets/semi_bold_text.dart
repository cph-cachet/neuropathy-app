import 'package:flutter/material.dart';

RichText semiBoldText(String text, TextStyle style, TextAlign textAlign) {
  checkHTML(text);

  bool isCurrentBold = false; //First String of splitText is '' or non-bold text
  List<String> splitText = text.split(RegExp(r'<b>|<\/b>'));

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
