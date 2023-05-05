//import 'package:carp_test_1/RPQuestionStepExt.dart';
import 'package:neuro_planner/step/steps/rp_vibration_step.dart';

import 'step/steps/rp_pain_slider_question_step.dart';
import 'step/steps/rp_image_question_step.dart';
import 'package:research_package/research_package.dart';
import 'package:research_package/model.dart';

import 'step/steps/rp_toggle_question_step.dart';

// Instruction
RPInstructionStep instructionStep = RPInstructionStep(
  identifier: 'InstructionID',
  title: 'Instructions',
  text: 'survey_introduction',
);

// Prick
List<RPChoice> siReAb = [
  RPChoice(text: 'Similar', value: 0),
  RPChoice(text: 'Reduced', value: 1),
  RPChoice(text: 'Absent', value: 2),
];
RPChoiceAnswerFormat siReAbAnswerFormat = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: siReAb);
RPImageQuestionStep left1 = RPImageQuestionStep(
    identifier: 'left1ID',
    title: 'Left leg',
    text:
        'Prick multiple spots in the blue area and select your prick sensitivity compared to the reference area. Only compare the sharpness of the prick sensation, not touch.',
    legImage: LegImage.leftLeg1,
    answerFormat: siReAbAnswerFormat);

// vibration
List<RPChoice> vibYesNo = [
  RPChoice(text: 'Yes', value: 0),
  RPChoice(text: 'No', value: 1)
];
RPChoiceAnswerFormat vibYesNoAnswerFormat = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: vibYesNo);
RPVibrationStep vib1 = RPVibrationStep(
    identifier: 'vib1',
    title: 'Left Leg',
    text:
        'Press play to start vibrating, and press the backside of the phone against the top side of the bone in your great toe.',
    vibrationSection: VibrationSection.leftToe,
    answerFormat: vibYesNoAnswerFormat);

// Pain
List<RPChoice> continueSkip = [
  RPChoice(text: 'Continue', value: 0),
  RPChoice(text: 'Skip', value: 1),
];
RPChoiceAnswerFormat continueSkipAnswerFormat = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: continueSkip);
RPQuestionStep skipPainStep = RPQuestionStep(
    identifier: 'skipPainID',
    title:
        'If you are experiencing pain in your feet, please answer the following questions.\n\nOtherwise, press the skip button',
    answerFormat: continueSkipAnswerFormat);

RPSliderAnswerFormat painSliderFormat =
    RPSliderAnswerFormat(minValue: 0, maxValue: 100, divisions: 100);
RPPainSliderQuestionStep painSlider = RPPainSliderQuestionStep(
    identifier: 'painSlider',
    title: 'On the scale below,\nmark your pain level.',
    answerFormat: painSliderFormat);

List<RPChoice> pain1Choices = [
  RPChoice(text: 'Pain feels like burning', value: 0),
  RPChoice(text: 'Sensation of painful cold', value: 1),
  RPChoice(text: 'Pain feels like electric shocks', value: 2),
  RPChoice(text: 'None of the above', value: 3),
];
RPChoiceAnswerFormat pain1Format = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.MultipleChoice, choices: pain1Choices);
RPQuestionStep pain1 = RPQuestionStep(
    identifier: 'pain1',
    title:
        'Does your pain present one or more of the following characteristics?',
    answerFormat: pain1Format);

List<RPChoice> pain2Choices = [
  RPChoice(text: 'Tingling', value: 0),
  RPChoice(text: 'Pins and needles', value: 1),
  RPChoice(text: 'Numbness', value: 2),
  RPChoice(text: 'Itching', value: 3),
  RPChoice(text: 'None of the above', value: 4)
];
RPChoiceAnswerFormat pain2Format = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.MultipleChoice, choices: pain2Choices);
RPQuestionStep pain2 = RPQuestionStep(
    identifier: 'pain2',
    title: 'In the same area, is your pain associated to one or more symptoms?',
    answerFormat: pain2Format);

List<RPChoice> pain3Choices = [
  RPChoice(text: 'Decreased sensitivity to touch', value: 0),
  RPChoice(text: 'Decreased sensitivity to pricking', value: 1),
  RPChoice(text: 'None of the above', value: 2)
];
RPChoiceAnswerFormat pain3Format = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.MultipleChoice, choices: pain3Choices);
RPQuestionStep pain3 = RPQuestionStep(
    identifier: 'pain3',
    title: 'Is the pain located in an area where the examination unveiled:',
    answerFormat: pain3Format);

List<RPChoice> painYesNo = [
  RPChoice(text: 'yes', value: 1),
  RPChoice(text: 'no', value: 0)
];
RPChoiceAnswerFormat painYesNoFormat = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: painYesNo);
RPToggleQuestionStep pain4 = RPToggleQuestionStep(
    identifier: 'pain4',
    title:
        'Use your fingers to gently stroke the areas where the pain is present.\n\n\nIs the pain provoked or increased by the stroking?',
    answerFormat: painYesNoFormat);

// Vibration
RPInstructionStep vibrationInstructionStep = RPInstructionStep(
  identifier: 'vibrationInstructionID',
  title: 'Vibration Test',
  text:
      'This begins the vibration sensation test.\n\nYou will test three points on each leg.\n\nWhen pressing the phone to your leg, use the backside of the phone.',
);

// Motor
List<RPChoice> motorYesNo = [
  RPChoice(text: 'Yes', value: 1),
  RPChoice(text: 'No', value: 0),
];
RPChoiceAnswerFormat motorYesNoFormat = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: motorYesNo);
RPImageQuestionStep leftmotor = RPImageQuestionStep(
    identifier: 'leftMotorID',
    title: 'Left Great Toe',
    legImage: LegImage.leftGreatToe,
    text:
        'Apply firm pressure with your fingers to the great toe.\n\nIs it difficult to overcome the pressure?',
    answerFormat: motorYesNoFormat);

// Completion
RPCompletionStep completionStep = RPCompletionStep(
    identifier: 'completionID',
    title: 'Examination completed',
    text: 'Thanks, buddy');

RPStepJumpRule noPain =
    RPStepJumpRule(answerMap: {1: vibrationInstructionStep.identifier});

RPNavigableOrderedTask linearSurveyTask = RPNavigableOrderedTask(
    identifier: 'SurveryTaskID',
    steps: [
      instructionStep,
      left1,
      vib1,
      skipPainStep,
      painSlider,
      pain1,
      pain2,
      pain3,
      pain4,
      vibrationInstructionStep,
      leftmotor,
      completionStep
    ])
  ..setNavigationRuleForTriggerStepIdentifier(noPain, skipPainStep.identifier);
