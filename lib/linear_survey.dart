//import 'package:carp_test_1/RPQuestionStepExt.dart';
import 'package:flutter/cupertino.dart';
import 'package:neuro_planner/step/steps/rp_instruction_step.dart';
import 'package:neuro_planner/survey/pain_questionaire_part.dart';
import 'package:neuro_planner/survey/symptoms_part.dart';
import 'package:neuro_planner/survey/prick_part.dart';
import 'package:neuro_planner/survey/motor_part.dart';
import 'package:neuro_planner/survey/vibration_part.dart';
import 'package:neuro_planner/survey/free_text_part.dart';

import 'package:research_package/research_package.dart';
import 'package:research_package/model.dart';

// Instruction
RPInstructionStepWithChildren introductionStep = RPInstructionStepWithChildren(
  identifier: 'InstructionID',
  title: 'begin-examination.title',
  instructionContent: [
    const Text('begin-examination.text-1', textAlign: TextAlign.center),
    const Text('begin-examination.text-2', textAlign: TextAlign.center)
  ],
);

// Completion
RPCompletionStep completionStep = RPCompletionStep(
    identifier: 'completionID',
    title: 'Examination completed',
    text: 'Thanks, buddy');

RPStepJumpRule noPain =
    RPStepJumpRule(answerMap: {0: vibrationInstructionStep.identifier});

RPNavigableOrderedTask linearSurveyTask = RPNavigableOrderedTask(
    closeAfterFinished: false,
    identifier: 'SurveryTaskID',
    steps: [
      introductionStep,
      symptomsStep,
      ...prickStepList,
      skipPainStep,
      ...painStepList,
      vibrationInstructionStep,
      ...vibrationStepList,
      ...motorStepList,
      freeTextStep,
      completionStep
    ])
  ..setNavigationRuleForTriggerStepIdentifier(noPain, skipPainStep.identifier);
