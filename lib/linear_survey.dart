import 'package:flutter/cupertino.dart';
import 'package:neuropathy_grading_tool/step/steps/rp_instruction_step.dart';
import 'package:neuropathy_grading_tool/survey/pain_questionaire_part.dart';
import 'package:neuropathy_grading_tool/survey/symptoms_part.dart';
import 'package:neuropathy_grading_tool/survey/prick_part.dart';
import 'package:neuropathy_grading_tool/survey/motor_part.dart';
import 'package:neuropathy_grading_tool/survey/vibration_part.dart';
import 'package:neuropathy_grading_tool/survey/free_text_part.dart';

import 'package:research_package/research_package.dart';
import 'package:research_package/model.dart';

// Instruction
RPInstructionStepWithChildren introductionStep = RPInstructionStepWithChildren(
  identifier: 'InstructionID',
  title: 'begin-examination.title',
  instructionContent: [
    const Text('begin-examination.text-1', textAlign: TextAlign.center),
    const Text('begin-examination.text-2', textAlign: TextAlign.center),
    const Text('begin-examination.text-3', textAlign: TextAlign.center),
    const Text('begin-examination.text-4', textAlign: TextAlign.center)
  ],
);

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
    ])
  ..setNavigationRuleForTriggerStepIdentifier(noPain, skipPainStep.identifier);
