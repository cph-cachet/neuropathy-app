// TODO: Localize
import 'package:flutter/material.dart';
import 'package:neuro_planner/step/steps/rp_image_question_step.dart';
import 'package:neuro_planner/step/steps/rp_instruction_step.dart';
import 'package:research_package/research_package.dart';

//TODO: fix \n in text
// todo: idea - make a list of text children and apply spacing in the ui

// todo move text to rpinstruction with children, just provide widget type
const String _motorIntroductionTitle = 'Motor examination';
const String _leftLegTitle = 'Left Leg';
const String _rightLegTitle = 'Right Leg';
const String _instruction =
    'Apply firm pressure with your fingers to the great toe.\n\nIs it difficult to overcome the pressure?';
const String _bottomSheetTitle = 'Overcoming pressure';
const String _bottomSheetText =
    'If you don\'t have symptoms in your hands, you can compare how your fingers overcome the pressure.\n\nIf you feel your great toe is weaker, answer YES to this question.';

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
  RPChoice(text: 'Yes', value: 1),
  RPChoice(text: 'No', value: 0),
];
RPChoiceAnswerFormat motorYesNoFormat = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: motorYesNo);

List<RPStep> motorStepList = [
  motorInstructionStep,
  ...MotorStrings.values
      .map((step) => RPImageQuestionStep(
          identifier: step.identifier,
          title: step.title,
          text: step.instruction,
          imagePath: step.imagePath,
          bottomSheetTitle: step.bottomSheetTitle,
          bottomSheetText: step.bottomSheetText,
          answerFormat: motorYesNoFormat))
      .toList()
];

enum MotorStrings {
  leftGreatToe('motor_left_toe', _leftLegTitle, _instruction,
      'assets/LeftGreatToe.png', _bottomSheetTitle, _bottomSheetText),
  rightGreatToe('motor_right_toe', _rightLegTitle, _instruction,
      'assets/RightGreatToe.png', _bottomSheetTitle, _bottomSheetText);

  const MotorStrings(this.identifier, this.title, this.instruction,
      this.imagePath, this.bottomSheetTitle, this.bottomSheetText);
  final String identifier;
  final String title;
  final String instruction;
  final String imagePath;
  final String bottomSheetTitle;
  final String bottomSheetText;
}
