import 'package:neuro_planner/step/steps/rp_vibration_step.dart';
import 'package:research_package/research_package.dart';

//TODO: localize
const String _leftLegTitle = 'Left Leg';
const String _rightLegTitle = 'Right Leg';
const String _kneeInstruction =
    'Press play to start vibrating, and press the backside of the phone against the bone just below your kneecap.';
const String _ankleInstruction =
    'Press play to start vibrating, and press the backside of the phone against the outside part of your ankle.';
const String _toeInstruction =
    'Press play to start vibrating, and press the backside of the phone against the top side of the bone in your great toe.';

List<RPStep> vibrationStepList = VibrationStrings.values
    .map((step) => stepGenerator(
        identifier: step.identifier,
        title: step.title,
        text: step.instruction,
        vibrationSection: step.imagePath))
    .toList();

List<RPChoice> vibrationYesNoChoiceList = [
  RPChoice(text: 'Yes', value: 0),
  RPChoice(text: 'No', value: 1)
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

//TODO: Localize
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
