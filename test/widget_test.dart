// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:neuropathy_grading_tool/main.dart';
import 'package:neuropathy_grading_tool/examination/vibration_part.dart';
import 'package:neuropathy_grading_tool/ui/widgets/toggle_button.dart';

import 'context_inj.dart';

void main() {
  testWidgets('Examination Toggle Button Test', (widgetTester) async {
    await widgetTester.pumpWidget(LocalizationsInj(
        child: ToggleButton(
            onPressed: (_) {}, answerFormat: vibrationAnswerFormat)));
    await widgetTester.pumpAndSettle();

    expect(find.byType(ToggleButton), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(2));
    final ToggleButtonState state =
        widgetTester.state(find.byType(ToggleButton));

    expect(state.selectedChoices, isEmpty);
    expect(state.isSelected, [false, false]);

    // Single tap, then change answer

    await widgetTester.tap(find.byType(Text).first);
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byType(Text).last);

    await widgetTester.pumpAndSettle();
    expect(state.selectedChoices, isNotEmpty);
    expect(state.selectedChoices.length, 1);
    expect(state.selectedChoices.first.text,
        vibrationAnswerFormat.choices.last.text);
    expect(state.isSelected, [false, true]);

    // Untapping not allowed

    await widgetTester.tap(find.byType(Text).first);
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byType(Text).first);
    await widgetTester.pumpAndSettle();

    expect(state.selectedChoices, isNotEmpty);
    expect(state.isSelected, [true, false]);
    expect(state.selectedChoices.length, 1);
    expect(state.selectedChoices.first.text,
        vibrationAnswerFormat.choices.first.text);
  });
}
