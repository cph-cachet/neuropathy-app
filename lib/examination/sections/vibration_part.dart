import 'package:neuropathy_grading_tool/examination/steps/rp_instruction_step.dart';
import 'package:neuropathy_grading_tool/examination/steps/rp_vibration_step.dart';
import 'package:research_package/research_package.dart';

// common strings
const String _leftLegTitle = 'common.left-leg';
const String _rightLegTitle = 'common.right-leg';
const String _kneeInstruction = 'vibration-knee.text';
const String _ankleInstruction = 'vibration-ankle.text';
const String _toeInstruction = 'vibration-toe.text';

/// The first step in the vibration section. This is an instruction step.
RPInstructionStepWithChildren vibrationInstructionStep =
    RPInstructionStepWithChildren(
        identifier: 'vibrationInstructionID',
        title: 'vibration-info.title',
        textContent: [
      'vibration-info.text-1',
      'vibration-info.text-2',
      'vibration-info.text-3',
      'vibration-info.text-4',
    ]);

/// List of [RPStep] objects that represent the vibration section.
/// The steps are generated using the [_stepGenerator] function.
/// The [_stepGenerator] function takes the [identifier], [title], [text] and [vibrationSection],
/// all of which are defined in [VibrationStrings].
List<RPStep> vibrationStepList = VibrationStrings.values
    .map((step) => _stepGenerator(
        identifier: step.identifier,
        title: step.title,
        text: step.instruction,
        vibrationSectionImage: step.imagePath))
    .toList();

/// List of [RPChoice] objects that represent the yes/no choices in the vibration section.
/// [value] decides how many points each option adds to the total score.
List<RPChoice> vibrationYesNoChoiceList = [
  RPChoice(text: 'common.yes', value: 0),
  RPChoice(text: 'common.no', value: 1)
];

/// The answer format for the yes/no choices in the vibration section.
RPChoiceAnswerFormat vibrationAnswerFormat = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice,
    choices: vibrationYesNoChoiceList);

/// A helper function that generates a vibration step.
/// The function takes the [identifier], [title], [text] and [vibrationSectionImage],
/// and returns an [RPVibrationStep] object.
RPVibrationStep _stepGenerator(
    {required String identifier,
    required String title,
    required String text,
    required String vibrationSectionImage}) {
  return RPVibrationStep(
      identifier: identifier,
      title: title,
      text: text,
      vibrationSectionImage: vibrationSectionImage,
      answerFormat: vibrationAnswerFormat);
}

/// List of [String] objects that represent the identifiers of the vibration steps
/// for the left leg.
List<String> leftVibrationSteps = VibrationStrings.values
    .where((element) => element.identifier.contains('left'))
    .map((e) => e.identifier)
    .toList();

/// List of [String] objects that represent the identifiers of the vibration steps
/// for the right leg.
List<String> rightVibrationSteps = VibrationStrings.values
    .where((element) => element.identifier.contains('right'))
    .map((e) => e.identifier)
    .toList();
List<String> allVibrationIdentifiers = [
  ...leftVibrationSteps,
  ...rightVibrationSteps
];

/// An enum with all ```Strings``` used in the vibration section.
/// It contains the [identifier], [title], [instruction] and [imagePath] for each step.
///
/// The [identifier] is used to identify the step.
/// The [title] is the title of the step.
/// The [instruction] is the instruction of the step.
/// The [imagePath] is the path to the image that is displayed in the step. It can be null, which is the case for the toe extension steps.
enum VibrationStrings {
  leftToe('viration_left_toe', _leftLegTitle, _toeInstruction,
      'assets/images/steps/vibration/left_toe.png'),
  leftAnkle('vibration_left_ankle', _leftLegTitle, _ankleInstruction,
      'assets/images/steps/vibration/left_ankle.png'),
  leftKnee('vibration_left_knee', _leftLegTitle, _kneeInstruction,
      'assets/images/steps/vibration/left_knee.png'),
  leftToeExtension('vibration_left_toe_extension', _leftLegTitle, 'left', ''),
  rightToe('vibration_right_toe', _rightLegTitle, _toeInstruction,
      'assets/images/steps/vibration/right_toe.png'),
  rightAnkle('vibration_right_ankle', _rightLegTitle, _ankleInstruction,
      'assets/images/steps/vibration/right_ankle.png'),
  rightKnee('vibration_right_knee', _rightLegTitle, _kneeInstruction,
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
