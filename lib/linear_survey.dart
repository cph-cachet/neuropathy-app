//import 'package:carp_test_1/RPQuestionStepExt.dart';
import 'package:flutter/cupertino.dart';
import 'package:neuro_planner/step/steps/rp_instruction_step.dart';
import 'package:neuro_planner/survey/pain_questionaire_part.dart';
import 'package:neuro_planner/survey/symptoms_part.dart';
import 'package:neuro_planner/survey/prick_part.dart';
import 'package:neuro_planner/survey/motor_part.dart';
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
      symptomsStep,
      ...prickStepList,
      skipPainStep,
      ...painStepList,
      vibrationInstructionStep,
      ...vibrationStepList,
      ...motorStepList,
      completionStep
    ])
  ..setNavigationRuleForTriggerStepIdentifier(noPain, skipPainStep.identifier);
