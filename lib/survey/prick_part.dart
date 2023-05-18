// TODO: Localize

//TODO: fix \n in text
// todo: idea - make a list of text children and apply spacing in the ui
import 'package:flutter/material.dart';
import 'package:neuro_planner/step/steps/rp_image_question_step.dart';
import 'package:neuro_planner/step/steps/rp_instruction_step.dart';
import 'package:neuro_planner/step/steps/rp_toggle_question_step.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';
import 'package:research_package/research_package.dart';

const String _prickIntroductionTitle = 'prick-info.title';
const List<Widget> _prickIntroText = [
  Text(
    'prick-info.text-1',
    textAlign: TextAlign.center,
  ),
  Text(
    'prick-info.text-2',
    textAlign: TextAlign.center,
  ),
  Text(
    'prick-info.text-3',
    textAlign: TextAlign.center,
  ),
];
const String _leftLegTitle = 'common.left-leg';
const String _rightLegTitle = 'common.right-leg';
const List<Text> _prickTextContent = [
  Text('prick-test.text-1', textAlign: TextAlign.center),
  Text('prick-test.text-2', textAlign: TextAlign.center),
  Text('prick-test.text-3', textAlign: TextAlign.center)
];
const String _bottomSheetTitle = 'prick-test.bottom-sheet-title';
const List<Text> _bottomSheetTextContent = [
  Text('prick-test.bottom-sheet-text-1'),
  Text('prick-test.bottom-sheet-text-2'),
];
const List<Text> _allodyniaQuestion = [
  Text('allodynia.text', textAlign: TextAlign.center)
];
const List<Text> _hyperaesthesiaQuestion = [
  Text('hypersensitivity.text', textAlign: TextAlign.center)
];

RPInstructionStepWithChildren prickInstructionStep =
    RPInstructionStepWithChildren(
  identifier: 'prickInstructionID',
  title: _prickIntroductionTitle,
  instructionContent: _prickIntroText,
);

List<RPChoice> pinPrickYesNo = [
  RPChoice(text: "common.yes", value: 1),
  RPChoice(text: 'common.no', value: 0)
];

List<RPChoice> saLeNo = [
  RPChoice(text: 'common.same', value: 0),
  RPChoice(text: 'common.less', value: 1),
  RPChoice(text: 'common.none', value: 2),
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
              textContent: step.textContent,
              imagePath: step.imagePath,
              bottomSheetTitle: step.bottomSheetTitle,
              bottomSheetTextContent: step.bottomSheetTextContent,
              answerFormat: pinPrickAnswerFormat(saLeNo))
          : RPToggleQuestionStep(
              identifier: step.identifier,
              title: step.title,
              text: step.textContent[0].data,
              answerFormat: pinPrickAnswerFormat(pinPrickYesNo)))
      .toList()
];

enum PrickStrings {
  leftLeg1(
      'prick_left_1',
      _leftLegTitle,
      _prickTextContent,
      'assets/images/steps/prick/left_leg_1.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  leftLeg2(
      'prick_left_2',
      _leftLegTitle,
      _prickTextContent,
      'assets/images/steps/prick/left_leg_2.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  leftLeg3(
      'prick_left_3',
      _leftLegTitle,
      _prickTextContent,
      'assets/images/steps/prick/left_leg_3.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  leftLeg4(
      'prick_left_4',
      _leftLegTitle,
      _prickTextContent,
      'assets/images/steps/prick/left_leg_4.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  leftLeg5(
      'prick_left_5',
      _leftLegTitle,
      _prickTextContent,
      'assets/images/steps/prick/left_leg_5.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  leftLeg6(
      'prick_left_6',
      _leftLegTitle,
      _prickTextContent,
      'assets/images/steps/prick/left_leg_6.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  leftLegAllodynia(
      'prick_left_allodynia', _leftLegTitle, _allodyniaQuestion, '', '', []),
  leftLegHyperaesthesia(
      'prick_left_hyper', _leftLegTitle, _hyperaesthesiaQuestion, '', '', []),
  rightLeg1(
      'prick_right_1',
      _rightLegTitle,
      _prickTextContent,
      'assets/images/steps/prick/right_leg_1.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  rightLeg2(
      'prick_right_2',
      _rightLegTitle,
      _prickTextContent,
      'assets/images/steps/prick/right_leg_2.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  rightLeg3(
      'prick_right_3',
      _rightLegTitle,
      _prickTextContent,
      'assets/images/steps/prick/right_leg_3.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  rightLeg4(
      'prick_right_4',
      _rightLegTitle,
      _prickTextContent,
      'assets/images/steps/prick/right_leg_4.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  rightLeg5(
      'prick_right_5',
      _rightLegTitle,
      _prickTextContent,
      'assets/images/steps/prick/right_leg_5.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  rightLeg6(
      'prick_right_6',
      _rightLegTitle,
      _prickTextContent,
      'assets/images/steps/prick/right_leg_6.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  righLegAllodynia(
      'prick_right_allodynia', _rightLegTitle, _allodyniaQuestion, '', '', []),
  rightLegHyperaesthesia(
      'prick_right_hyper', _rightLegTitle, _hyperaesthesiaQuestion, '', '', []);

  const PrickStrings(this.identifier, this.title, this.textContent,
      this.imagePath, this.bottomSheetTitle, this.bottomSheetTextContent);
  final String identifier;
  final String title;
  final List<Text> textContent;
  final String imagePath;
  final String bottomSheetTitle;
  final List<Text> bottomSheetTextContent;
}
