//import 'package:carp_test_1/RPQuestionStepExt.dart';
import 'package:neuro_planner/survey/pain_questionaire_part.dart';
import 'package:neuro_planner/survey/symptoms_part.dart';
import 'package:neuro_planner/survey/vibration_part.dart';

import 'step/steps/rp_image_question_step.dart';
import 'package:research_package/research_package.dart';
import 'package:research_package/model.dart';

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
    RPStepJumpRule(answerMap: {0: vibrationInstructionStep.identifier});

RPNavigableOrderedTask linearSurveyTask = RPNavigableOrderedTask(
    identifier: 'SurveryTaskID',
    steps: [
      symptomsStep,
      instructionStep,
      left1,
      skipPainStep,
      ...painStepList,
      vibrationInstructionStep,
      ...vibrationStepList,
      leftmotor,
      completionStep
    ])
  ..setNavigationRuleForTriggerStepIdentifier(noPain, skipPainStep.identifier);
