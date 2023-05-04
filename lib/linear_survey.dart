//import 'package:carp_test_1/RPQuestionStepExt.dart';
import 'package:neuro_planner/step/steps/rp_vibration_step.dart';

import 'RPPainSliderQuestionStep.dart';
import 'RPPrickQuestionStep.dart';
import 'package:research_package/research_package.dart';
import 'package:research_package/model.dart';

// Instruction
RPInstructionStep instructionStep = RPInstructionStep(
  identifier: 'InstructionID',
  title: 'Instructions',
  text: 'survey_introduction',
);

// Prick
List<RPChoice> siReNo = [
  RPChoice(text: 'Similar', value: 0),
  RPChoice(text: 'Reduced', value: 1),
  RPChoice(text: 'Absent', value: 2),
];
RPChoiceAnswerFormat siReNoAnswerFormat = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: siReNo);
RPPrickQuestionStep left1 = RPPrickQuestionStep(
    identifier: 'left1ID',
    title: 'Left leg',
    text:
        'Prick multiple spots in the blue area and select your prick sensitivity compared to the reference area. Only compare the sharpness of the prick sensation, not touch.',
    prickSection: PrickSection.Left1,
    answerFormat: siReNoAnswerFormat);
/*
RPQuestionStep leftLeg1 = RPQuestionStep(
    identifier: 'leftLeg1ID',
    image: Image.asset('assets/RightLeg1.png', height: 300),
    title:
        'Prick multiple spots in the blue area and select your prick sensitivity compared to the reference area. Only compare the sharpness of the prick sensation, not touch.',
    answerFormat: siReNoAnswerFormat);
RPQuestionStep leftLeg2 = RPQuestionStep(
    identifier: 'leftLeg2ID',
    image: Image.asset('assets/RightLeg2.png', height: 300),
    title:
        'Prick multiple spots in the blue area and select your prick sensitivity compared to the reference area. Only compare the sharpness of the prick sensation, not touch.',
    answerFormat: siReNoAnswerFormat);
*/
// vibration
List<RPChoice> vibYesNo = [
  RPChoice(text: 'Yes', value: 0),
  RPChoice(text: 'No', value: 1)
];
RPChoiceAnswerFormat vibrationAnswerFormat = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: vibYesNo);

RPVibrationStep vib1 = RPVibrationStep(
    identifier: 'vib1',
    title: 'Left Leg',
    text:
        'Press play to start vibrating, and press the backside of the phone against the top side of the bone in your great toe.',
    vibrationSection: VibrationSection.leftToe,
    answerFormat: vibrationAnswerFormat);

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
    title: 'On the scale below, mark your pain level.',
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

// Vibration
RPInstructionStep vibrationInstructionStep = RPInstructionStep(
  identifier: 'vibrationInstructionID',
  title: 'Vibration Test',
  text:
      'This begins the vibration sensation test.\n\nYou will test three points on each leg.\n\nWhen pressing the phone to your leg, use the backside of the phone.',
);

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
      vibrationInstructionStep,
      completionStep
    ])
  ..setNavigationRuleForTriggerStepIdentifier(noPain, skipPainStep.identifier);
