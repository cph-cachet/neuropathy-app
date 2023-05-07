// TODO: Localize
import 'package:neuro_planner/step/steps/rp_image_question_step.dart';
import 'package:research_package/research_package.dart';

const String _prickIntroductionTitle = 'Prick Test';
const String _prickIntroductionText =
    'Here you will test the pin-prick sensitivity of your legs using a needle or a sefety pin.\n\nChoose either the neck or the clavicle area to use as reference.\n\nPrick the reference area multiple times to compare sensitivity with the tested areas.';
const String _leftLegTitle = 'Left Leg';
const String _rightLegTitle = 'Right Leg';
const String _prickInstruction =
    'Prick multiple spots in the blue area and select your prick sensitivity compared to the reference area. Only compare the sharpness of the prick sensation, not touch.';
const String _bottomSheetTitle = 'Pin-prick test';
const String _bottomSheetText =
    'When pricking the area, follow the pictures. In sections 1-2 prick on the top of your foot, in sections 3-6 prick on the side of your leg. Try to avoid pricking directly over a bone.\n\nIf you fell the area is more sensitive to pricking than your referenced area, answer SIMILAR.';

RPInstructionStep prickInstructionStep = RPInstructionStep(
  identifier: 'prickInstructionID',
  title: _prickIntroductionTitle,
  text: _prickIntroductionText,
);

List<RPChoice> siReAb = [
  RPChoice(text: 'Similar', value: 0),
  RPChoice(text: 'Reduced', value: 1),
  RPChoice(text: 'Absent', value: 2),
];
RPChoiceAnswerFormat siReAbAnswerFormat = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: siReAb);

List<RPStep> prickStepList = [
  prickInstructionStep,
  ...PrickStrings.values
      .map((step) => RPImageQuestionStep(
          identifier: step.identifier,
          title: step.title,
          text: step.instruction,
          imagePath: step.imagePath,
          bottomSheetTitle: step.bottomSheetTitle,
          bottomSheetText: step.bottomSheetText,
          answerFormat: siReAbAnswerFormat))
      .toList()
];

enum PrickStrings {
  leftLeg1('prick_left_1', _leftLegTitle, _prickInstruction,
      'assets/LeftLeg1.png', _bottomSheetTitle, _bottomSheetText),
  leftLeg2('prick_left_2', _leftLegTitle, _prickInstruction,
      'assets/LeftLeg2.png', _bottomSheetTitle, _bottomSheetText),
  leftLeg3('prick_left_3', _leftLegTitle, _prickInstruction,
      'assets/LeftLeg3.png', _bottomSheetTitle, _bottomSheetText),
  leftLeg4('prick_left_4', _leftLegTitle, _prickInstruction,
      'assets/LeftLeg4.png', _bottomSheetTitle, _bottomSheetText),
  leftLeg5('prick_left_5', _leftLegTitle, _prickInstruction,
      'assets/LeftLeg5.png', _bottomSheetTitle, _bottomSheetText),
  leftLeg6('prick_left_6', _leftLegTitle, _prickInstruction,
      'assets/LeftLeg6.png', _bottomSheetTitle, _bottomSheetText),
  rightLeg1('prick_right_1', _rightLegTitle, _prickInstruction,
      'assets/RightLeg1.png', _bottomSheetTitle, _bottomSheetText),
  rightLeg2('prick_right_2', _rightLegTitle, _prickInstruction,
      'assets/RightLeg2.png', _bottomSheetTitle, _bottomSheetText),
  rightLeg3('prick_right_3', _rightLegTitle, _prickInstruction,
      'assets/RightLeg3.png', _bottomSheetTitle, _bottomSheetText),
  rightLeg4('prick_right_4', _rightLegTitle, _prickInstruction,
      'assets/RightLeg4.png', _bottomSheetTitle, _bottomSheetText),
  rightLeg5('prick_right_5', _rightLegTitle, _prickInstruction,
      'assets/RightLeg5.png', _bottomSheetTitle, _bottomSheetText),
  rightLeg6('prick_right_6', _rightLegTitle, _prickInstruction,
      'assets/RightLeg6.png', _bottomSheetTitle, _bottomSheetText);

  const PrickStrings(this.identifier, this.title, this.instruction,
      this.imagePath, this.bottomSheetTitle, this.bottomSheetText);
  final String identifier;
  final String title;
  final String instruction;
  final String imagePath;
  final String bottomSheetTitle;
  final String bottomSheetText;
}
