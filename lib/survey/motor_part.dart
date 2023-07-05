import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/step/steps/rp_image_question_step.dart';
import 'package:neuropathy_grading_tool/step/steps/rp_instruction_step.dart';
import 'package:research_package/research_package.dart';

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

/// An instruction step for the motor part of the examination.
RPInstructionStepWithChildren motorInstructionStep =
    RPInstructionStepWithChildren(
  identifier: 'motorInstructionID',
  title: _motorIntroductionTitle,
  instructionContent: _motorIntroContent,
);

/// An answer format for all motor steps.
/// [value] decides how many points each option add to the total score
List<RPChoice> motorYesNo = [
  RPChoice(text: 'common.yes', value: 2),
  RPChoice(text: 'common.no', value: 0),
];
RPChoiceAnswerFormat motorYesNoFormat = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: motorYesNo);

/// A list of all motor steps.
///
/// The [motorInstructionStep] is the first step of the motor part of the examination.
/// The [motorYesNoFormat] is the answer format for all non-instruction motor steps.
/// Both members of the [MotorStrings] enum are mapped to [RPImageQuestionStep]s.
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

/// All strings used in the motor part of the examination.
///
/// The [identifier] is the step identifier.
/// The [title] is the step title, filling the step UI  along with [textContent].
/// The [imagePath] is the image path to display in the step.
/// The [bottomSheetTitle] and [bottomSheetTextContent] are used to create the bottom sheet
/// that gives the user more information about the step.
enum MotorStrings {
  leftGreatToe(
      'motor_left_toe',
      _leftLegTitle,
      _motorTextContent,
      'assets/images/steps/left_great_toe.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  rightGreatToe(
      'motor_right_toe',
      _rightLegTitle,
      _motorTextContent,
      'assets/images/steps/right_great_toe.png',
      _bottomSheetTitle,
      _bottomSheetTextContent);

  const MotorStrings(this.identifier, this.title, this.textContent,
      this.imagePath, this.bottomSheetTitle, this.bottomSheetTextContent);
  final String identifier;
  final String title;
  final List<String> textContent;
  final String imagePath;
  final String bottomSheetTitle;
  final List<String> bottomSheetTextContent;
}
