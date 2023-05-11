// TODO: Localize

//TODO: fix \n in text
// todo: idea - make a list of text children and apply spacing in the ui
import 'package:flutter/material.dart';
import 'package:neuro_planner/step/steps/rp_image_question_step.dart';
import 'package:neuro_planner/step/steps/rp_instruction_step.dart';
import 'package:neuro_planner/step/steps/rp_toggle_question_step.dart';
import 'package:research_package/research_package.dart';

const String _prickIntroductionTitle = 'Prick Test';
const List<Widget> _prickIntroText = [
  Text(
    'Now you will test the pin-prick sensitivity of your legs using a needle or a safety pin.',
    textAlign: TextAlign.center,
  ),
  Text(
    'Choose either the neck or the clavicle area to use as reference.',
    textAlign: TextAlign.center,
  ),
  Text(
    'During the test, prick both the reference area and the tested area to compare sensitivity.',
    textAlign: TextAlign.center,
  ),
];
const String _leftLegTitle = 'Left Leg';
const String _rightLegTitle = 'Right Leg';
const String _prickInstruction =
    '1: Prick multiple spots in the chosen reference area. 2: Prick multiple spots in the blue area on the leg. How sensitive is the area on the leg compared to the reference area? Only compare the sharpness of the prick sensation, not touch.';
const String _bottomSheetTitle = 'Pin-prick test';
const String _bottomSheetText =
    'When pricking the area, follow the pictures. In the first two areas prick on the top of your foot, in the other areas prick on the side of your leg. Try to avoid pricking directly over a bone.\n\nIf you feel the area is more sensitive to pricking than your reference area, also answer SAME.';
const String _allodyniaQuestion =
    'During the pin-prick examination, did you feel increased pain from pricking in the foot or toes?';
const String _hyperaesthesiaQuestion =
    'Do you experience discomfort or pain when touching the foot or toes?';

RPInstructionStepWithChildren prickInstructionStep =
    RPInstructionStepWithChildren(
  identifier: 'prickInstructionID',
  title: _prickIntroductionTitle,
  instructionContent: _prickIntroText,
);

List<RPChoice> pinPrickYesNo = [
  RPChoice(text: "Yes", value: 1),
  RPChoice(text: 'No', value: 0)
];

List<RPChoice> saLeNo = [
  RPChoice(text: 'Same', value: 0),
  RPChoice(text: 'Less', value: 1),
  RPChoice(text: 'None', value: 2),
];
RPChoiceAnswerFormat pinPrickAnswerFormat(List<RPChoice> choices) {
  return RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: choices);
}

List<RPStep> prickStepList = [
  prickInstructionStep,
  ...PrickStrings.values
      .map((step) => step.imagePath.isNotEmpty
          ? RPImageQuestionStep(
              identifier: step.identifier,
              title: step.title,
              text: step.instruction,
              imagePath: step.imagePath,
              bottomSheetTitle: step.bottomSheetTitle,
              bottomSheetText: step.bottomSheetText,
              answerFormat: pinPrickAnswerFormat(saLeNo))
          : RPToggleQuestionStep(
              identifier: step.identifier,
              title: step.title,
              text: step.instruction,
              answerFormat: pinPrickAnswerFormat(pinPrickYesNo)))
      .toList()
];

enum PrickStrings {
  leftLeg1(
      'prick_left_1',
      _leftLegTitle,
      _prickInstruction,
      'assets/images/steps/prick/left_leg_1.png',
      _bottomSheetTitle,
      _bottomSheetText),
  leftLeg2(
      'prick_left_2',
      _leftLegTitle,
      _prickInstruction,
      'assets/images/steps/prick/left_leg_2.png',
      _bottomSheetTitle,
      _bottomSheetText),
  leftLeg3(
      'prick_left_3',
      _leftLegTitle,
      _prickInstruction,
      'assets/images/steps/prick/left_leg_3.png',
      _bottomSheetTitle,
      _bottomSheetText),
  leftLeg4(
      'prick_left_4',
      _leftLegTitle,
      _prickInstruction,
      'assets/images/steps/prick/left_leg_4.png',
      _bottomSheetTitle,
      _bottomSheetText),
  leftLeg5(
      'prick_left_5',
      _leftLegTitle,
      _prickInstruction,
      'assets/images/steps/prick/left_leg_5.png',
      _bottomSheetTitle,
      _bottomSheetText),
  leftLeg6(
      'prick_left_6',
      _leftLegTitle,
      _prickInstruction,
      'assets/images/steps/prick/left_leg_6.png',
      _bottomSheetTitle,
      _bottomSheetText),
  leftLegAllodynia(
      'prick_left_allodynia', _leftLegTitle, _allodyniaQuestion, '', '', ''),
  leftLegHyperaesthesia(
      'prick_left_hyper', _leftLegTitle, _hyperaesthesiaQuestion, '', '', ''),
  rightLeg1(
      'prick_right_1',
      _rightLegTitle,
      _prickInstruction,
      'assets/images/steps/prick/right_leg_1.png',
      _bottomSheetTitle,
      _bottomSheetText),
  rightLeg2(
      'prick_right_2',
      _rightLegTitle,
      _prickInstruction,
      'assets/images/steps/prick/right_leg_2.png',
      _bottomSheetTitle,
      _bottomSheetText),
  rightLeg3(
      'prick_right_3',
      _rightLegTitle,
      _prickInstruction,
      'assets/images/steps/prick/right_leg_3.png',
      _bottomSheetTitle,
      _bottomSheetText),
  rightLeg4(
      'prick_right_4',
      _rightLegTitle,
      _prickInstruction,
      'assets/images/steps/prick/right_leg_4.png',
      _bottomSheetTitle,
      _bottomSheetText),
  rightLeg5(
      'prick_right_5',
      _rightLegTitle,
      _prickInstruction,
      'assets/images/steps/prick/right_leg_5.png',
      _bottomSheetTitle,
      _bottomSheetText),
  rightLeg6(
      'prick_right_6',
      _rightLegTitle,
      _prickInstruction,
      'assets/images/steps/prick/right_leg_6.png',
      _bottomSheetTitle,
      _bottomSheetText),
  righLegAllodynia(
      'prick_right_allodynia', _rightLegTitle, _allodyniaQuestion, '', '', ''),
  rightLegHyperaesthesia(
      'prick_right_hyper', _rightLegTitle, _hyperaesthesiaQuestion, '', '', '');

  const PrickStrings(this.identifier, this.title, this.instruction,
      this.imagePath, this.bottomSheetTitle, this.bottomSheetText);
  final String identifier;
  final String title;
  final String instruction;
  final String imagePath;
  final String bottomSheetTitle;
  final String bottomSheetText;
}
