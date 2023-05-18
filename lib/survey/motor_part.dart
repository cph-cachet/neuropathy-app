// TODO: Localize
import 'package:flutter/material.dart';
import 'package:neuro_planner/step/steps/rp_image_question_step.dart';
import 'package:neuro_planner/step/steps/rp_instruction_step.dart';
import 'package:research_package/research_package.dart';

//TODO: fix \n in text
// todo: idea - make a list of text children and apply spacing in the ui

// todo move text to rpinstruction with children, just provide widget type
const String _motorIntroductionTitle = 'Motor examination';
const String _leftLegTitle = 'common.left-leg';
const String _rightLegTitle = 'common.right-leg';
const List<Text> _motorTextContent = [
  Text('motor-test.text-1', textAlign: TextAlign.center),
  Text('motor-test.text-2', textAlign: TextAlign.center)
];
const String _bottomSheetTitle = 'motor-test.bottom-sheet-title';
const String _bottomSheetText =
    'If you don\'t have symptoms in your hands, you can compare how your fingers overcome the pressure.\n\nIf you feel your great toe is weaker, answer <b>YES</b> to this question.';

RPInstructionStepWithChildren motorInstructionStep =
    RPInstructionStepWithChildren(
  identifier: 'motorInstructionID',
  title: _motorIntroductionTitle,
  instructionContent: [
    const Text(
      'Here you will test the strength of your great toes.',
      textAlign: TextAlign.center,
    ),
    const Text(
      'The great toe can usually resist a lot of pressure. In the test press down the great toe with your fingers while resisting the pressure.',
      textAlign: TextAlign.center,
    ),
  ],
);

List<RPChoice> motorYesNo = [
  RPChoice(text: 'common.yes', value: 1),
  RPChoice(text: 'common.no', value: 0),
];
RPChoiceAnswerFormat motorYesNoFormat = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: motorYesNo);

List<RPStep> motorStepList = [
  motorInstructionStep,
  ...MotorStrings.values
      .map((step) => RPImageQuestionStep(
          identifier: step.identifier,
          title: step.title,
          textContent: step.textContent,
          imagePath: step.imagePath,
          bottomSheetTitle: step.bottomSheetTitle,
          bottomSheetText: step.bottomSheetText,
          answerFormat: motorYesNoFormat))
      .toList()
];

enum MotorStrings {
  leftGreatToe('motor_left_toe', _leftLegTitle, _motorTextContent,
      'assets/LeftGreatToe.png', _bottomSheetTitle, _bottomSheetText),
  rightGreatToe('motor_right_toe', _rightLegTitle, _motorTextContent,
      'assets/RightGreatToe.png', _bottomSheetTitle, _bottomSheetText);

  const MotorStrings(this.identifier, this.title, this.textContent,
      this.imagePath, this.bottomSheetTitle, this.bottomSheetText);
  final String identifier;
  final String title;
  final List<Text> textContent;
  final String imagePath;
  final String bottomSheetTitle;
  final String bottomSheetText;
}
