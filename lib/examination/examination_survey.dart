import 'package:flutter/cupertino.dart';
import 'package:neuropathy_grading_tool/examination/steps/rp_instruction_step.dart';
import 'package:neuropathy_grading_tool/examination/pain_questionaire_part.dart';
import 'package:neuropathy_grading_tool/examination/symptoms_part.dart';
import 'package:neuropathy_grading_tool/examination/prick_part.dart';
import 'package:neuropathy_grading_tool/examination/motor_part.dart';
import 'package:neuropathy_grading_tool/examination/vibration_part.dart';
import 'package:neuropathy_grading_tool/examination/sections/free_text_part.dart';

import 'package:research_package/research_package.dart';
import 'package:research_package/model.dart';

/// Introduction step with general examination information.
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

/// Rule to skip to [vibrationInstructionStep] if user selects they don't experience pain in feet.
RPStepJumpRule noPain =
    RPStepJumpRule(answerMap: {0: vibrationInstructionStep.identifier});

/// The examination task. Collects all the steps and sets the navigation rules.
///
/// The user cannot go back to previous steps after confirming the answer by tapping the next button.
/// The examination task is not closed after finishing, so the user can see the results and choose further actions.
RPNavigableOrderedTask examinationTask = RPNavigableOrderedTask(
    closeAfterFinished: false,
    identifier: 'ExaminationTaskID',
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
