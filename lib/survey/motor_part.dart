// TODO: Localize
import 'package:flutter/material.dart';
import 'package:neuro_planner/step/steps/rp_image_question_step.dart';
import 'package:neuro_planner/step/steps/rp_instruction_step.dart';
import 'package:research_package/research_package.dart';

//TODO: fix \n in text
// todo: idea - make a list of text children and apply spacing in the ui

// todo move text to rpinstruction with children, just provide widget type
const String _motorIntroductionTitle = 'motor-info.title';
const List<Widget> _motorIntroContent = [
  Text(
    'motor-info.text-1',
    textAlign: TextAlign.center,
  ),
  Text(
    'motor-info.text-2',
    textAlign: TextAlign.center,
  ),
];

const String _leftLegTitle = 'common.left-leg';
const String _rightLegTitle = 'common.right-leg';
const List<String> _motorTextContent = [
  'motor-test.text-1',
  'motor-test.text-2'
];
const String _bottomSheetTitle = 'motor-test.bottom-sheet-title';
const List<String> _bottomSheetTextContent = [
  'motor-test.bottom-sheet-text-1',
  'motor-test.bottom-sheet-text-2'
];

RPInstructionStepWithChildren motorInstructionStep =
    RPInstructionStepWithChildren(
  identifier: 'motorInstructionID',
  title: _motorIntroductionTitle,
  instructionContent: _motorIntroContent,
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
          bottomSheetTextContent: step.bottomSheetTextContent,
          answerFormat: motorYesNoFormat))
      .toList()
];

enum MotorStrings {
  leftGreatToe('motor_left_toe', _leftLegTitle, _motorTextContent,
      'assets/LeftGreatToe.png', _bottomSheetTitle, _bottomSheetTextContent),
  rightGreatToe('motor_right_toe', _rightLegTitle, _motorTextContent,
      'assets/RightGreatToe.png', _bottomSheetTitle, _bottomSheetTextContent);

  const MotorStrings(this.identifier, this.title, this.textContent,
      this.imagePath, this.bottomSheetTitle, this.bottomSheetTextContent);
  final String identifier;
  final String title;
  final List<String> textContent;
  final String imagePath;
  final String bottomSheetTitle;
  final List<String> bottomSheetTextContent;
}
