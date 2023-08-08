import 'package:neuropathy_grading_tool/examination/steps/rp_image_question_step.dart';
import 'package:neuropathy_grading_tool/examination/steps/rp_instruction_step.dart';
import 'package:neuropathy_grading_tool/examination/steps/rp_toggle_question_step.dart';
import 'package:research_package/research_package.dart';

// Strings common across the pin prick section.
const String _leftLegTitle = 'common.left-leg';
const String _rightLegTitle = 'common.right-leg';

/// List of strings that are the text content for all toe prick steps.
const List<String> _toePrickTextContent = [
  'prick-test.text-1',
  'prick-test.text-2-toe',
  'prick-test.text-3-toe'
];

/// List of strings that are the text content for all foot prick steps.
const List<String> _footPrickTextContent = [
  'prick-test.text-1',
  'prick-test.text-2-foot',
  'prick-test.text-3-foot'
];

/// List of strings that are the text content for all leg prick steps.
const List<String> _legPrickTextContent = [
  'prick-test.text-1',
  'prick-test.text-2-leg',
  'prick-test.text-3-leg'
];

/// Bottom sheet title for all prick steps.
const String _bottomSheetTitle = 'prick-test.bottom-sheet-title';

/// Bottom sheet content Strings for all prick steps.
const List<String> _bottomSheetTextContent = [
  'prick-test.bottom-sheet-text-1',
  'prick-test.bottom-sheet-text-2',
  'prick-test.bottom-sheet-text-3',
];

/// Allodynia step text content strings
const List<String> _allodyniaQuestion = ['allodynia.text'];

/// Hyperaesthesia step text content strings
const List<String> _hyperaesthesiaQuestion = ['hypersensitivity.text'];

/// This is the instruction step for the pin prick section.
RPInstructionStepWithChildren prickInstructionStep =
    RPInstructionStepWithChildren(
  identifier: 'prickInstructionID',
  title: 'prick-info.title',
  textContent: [
    'prick-info.text-1',
    'prick-info.text-2',
    'prick-info.text-3',
  ],
);

/// List of [RPChoice] objects that represent the yes/no choices in the pin-prick section.
/// [value] decides how many points each option add to the total score.
List<RPChoice> pinPrickYesNo = [
  RPChoice(text: "common.yes", value: 1),
  RPChoice(text: 'common.no', value: 0)
];

/// List of [RPChoice] objects that represent the Same/Less/None choices in the pin-prick section.
/// [value] decides how many points each option add to the total score.
List<RPChoice> sameLessNone = [
  RPChoice(text: 'common.same', value: 0),
  RPChoice(text: 'common.less', value: 1),
  RPChoice(text: 'common.none', value: 2),
];

/// [RPChoiceAnswerFormat] generator function for the pin prick questions.
/// All of the questions in this section are single choice
/// The choices are displayed as a [ToggleButton].
RPChoiceAnswerFormat pinPrickAnswerFormat(List<RPChoice> choices) {
  return RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: choices);
}

/// List of [RPStep]s that make up the pin prick section.
/// The first step is the instructions steps,
/// Then the [PrickStrings] are mapped to [RPImageQuestionStep] for pin-prick questions
/// and [RPToggleQuestionStep] for the remaining questions.
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
              answerFormat: pinPrickAnswerFormat(sameLessNone))
          : RPToggleQuestionStep(
              identifier: step.identifier,
              title: step.title,
              text: step.textContent[0],
              answerFormat: pinPrickAnswerFormat(pinPrickYesNo)))
      .toList()
];

/// An enum with all ```Strings``` needed for the pin prick section steps.
/// It contains the [identifier], [title], [textContent], [imagePath], [bottomSheetTitle]
/// and [bottomSheetTextContent].
///
/// The [identifier] is used to identify the step.
/// The [title] is the title of the step.
/// The [imagePath] is the path to the image that is displayed in the step.
/// The [textContent] is the textt part of the step.
/// [bottomSheetTitle] and [bottomSheetTextContent] are to generate bottom sheet helpers.
///
/// For hyperaesthesia and allodynia steps, [imagePath], [bottomSheetTitle] and [bottomSheetTextContent]
/// are ampty as these questions only use text instructions.
enum PrickStrings {
  leftLeg1(
      'prick_left_1',
      _leftLegTitle,
      _toePrickTextContent,
      'assets/images/steps/prick/left_leg_1.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  leftLeg2(
      'prick_left_2',
      _leftLegTitle,
      _footPrickTextContent,
      'assets/images/steps/prick/left_leg_2.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  leftLeg3(
      'prick_left_3',
      _leftLegTitle,
      _legPrickTextContent,
      'assets/images/steps/prick/left_leg_3.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  leftLeg4(
      'prick_left_4',
      _leftLegTitle,
      _legPrickTextContent,
      'assets/images/steps/prick/left_leg_4.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  leftLeg5(
      'prick_left_5',
      _leftLegTitle,
      _legPrickTextContent,
      'assets/images/steps/prick/left_leg_5.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  leftLeg6(
      'prick_left_6',
      _leftLegTitle,
      _legPrickTextContent,
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
      _toePrickTextContent,
      'assets/images/steps/prick/right_leg_1.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  rightLeg2(
      'prick_right_2',
      _rightLegTitle,
      _footPrickTextContent,
      'assets/images/steps/prick/right_leg_2.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  rightLeg3(
      'prick_right_3',
      _rightLegTitle,
      _legPrickTextContent,
      'assets/images/steps/prick/right_leg_3.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  rightLeg4(
      'prick_right_4',
      _rightLegTitle,
      _legPrickTextContent,
      'assets/images/steps/prick/right_leg_4.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  rightLeg5(
      'prick_right_5',
      _rightLegTitle,
      _legPrickTextContent,
      'assets/images/steps/prick/right_leg_5.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  rightLeg6(
      'prick_right_6',
      _rightLegTitle,
      _legPrickTextContent,
      'assets/images/steps/prick/right_leg_6.png',
      _bottomSheetTitle,
      _bottomSheetTextContent),
  righLegAllodynia(
      'prick_right_allodynia', _rightLegTitle, _allodyniaQuestion, '', '', []),
  rightLegHyperaesthesia(
      'prick_right_hyper', _rightLegTitle, _hyperaesthesiaQuestion, '', '', []);

  const PrickStrings(this.identifier, this.title, this.textContent,
      this.imagePath, this.bottomSheetTitle, this.bottomSheetTextContent);

  /// Identifier for the [RPStep]
  final String identifier;

  /// Title of the step.
  final String title;

  /// Text content of the step.
  final List<String> textContent;

  /// Image path for the step image
  final String imagePath;

  /// Helper bottom sheet title
  final String bottomSheetTitle;

  /// Content of the bottom sheet
  final List<String> bottomSheetTextContent;
}

/// A list of identifiers of pin prick steps.
List<String> pinPrickIdentifiers =
    PrickStrings.values.map((e) => e.identifier).toList();
