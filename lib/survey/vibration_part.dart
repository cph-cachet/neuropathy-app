import 'package:flutter/material.dart';
import 'package:neuro_planner/step/steps/rp_instruction_step.dart';
import 'package:neuro_planner/step/steps/rp_vibration_step.dart';
import 'package:research_package/research_package.dart';

const String _leftLegTitle = 'common.left-leg';
const String _rightLegTitle = 'common.right-leg';
const String _kneeInstruction = 'vibration-knee.text';
const String _ankleInstruction = 'vibration-ankle.text';
const String _toeInstruction = 'vibration-toe.text';

RPInstructionStepWithChildren vibrationInstructionStep =
    RPInstructionStepWithChildren(
        identifier: 'vibrationInstructionID',
        title: 'vibration-info.title',
        instructionContent: [
      const Text(
        'vibration-info.text-1',
        textAlign: TextAlign.center,
      ),
      const Text(
        'vibration-info.text-2',
        textAlign: TextAlign.center,
      ),
      const Text(
        'vibration-info.text-3',
        textAlign: TextAlign.center,
      ),
    ]);

List<RPStep> vibrationStepList = VibrationStrings.values
    .map((step) => stepGenerator(
        identifier: step.identifier,
        title: step.title,
        text: step.instruction,
        vibrationSection: step.imagePath))
    .toList();

List<RPChoice> vibrationYesNoChoiceList = [
  RPChoice(text: 'common.yes', value: 0),
  RPChoice(text: 'common.no', value: 1)
];

RPChoiceAnswerFormat vibrationAnswerFormat = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice,
    choices: vibrationYesNoChoiceList);

RPVibrationStep stepGenerator(
    {required String identifier,
    required String title,
    required String text,
    required String vibrationSection}) {
  return RPVibrationStep(
      identifier: identifier,
      title: title,
      text: text,
      vibrationSection: vibrationSection,
      answerFormat: vibrationAnswerFormat);
}

enum VibrationStrings {
  leftToe('viration_left_toe', _leftLegTitle, _toeInstruction,
      'assets/images/steps/vibration/left_toe.png'),
  leftAnkle('vibration_left_ankle', _leftLegTitle, _ankleInstruction,
      'assets/images/steps/vibration/left_ankle.png'),
  leftKnee('vibration_left_knee', _leftLegTitle, _kneeInstruction,
      'assets/images/steps/vibration/left_knee.png'),
  leftToeExtension('vibration_left_toe_extension', _leftLegTitle, 'left', ''),
  rightToe('right_toe', _rightLegTitle, _toeInstruction,
      'assets/images/steps/vibration/right_toe.png'),
  rightAnkle('right_ankle', _rightLegTitle, _ankleInstruction,
      'assets/images/steps/vibration/right_ankle.png'),
  rightKnee('right_knee', _rightLegTitle, _kneeInstruction,
      'assets/images/steps/vibration/right_knee.png'),
  rightToeExtension(
      'vibration_right_toe_extension', _rightLegTitle, 'right', '');

  const VibrationStrings(
      this.identifier, this.title, this.instruction, this.imagePath);
  final String identifier;
  final String title;
  final String instruction;
  final String imagePath;
}
