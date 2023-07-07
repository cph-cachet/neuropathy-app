import 'package:neuropathy_grading_tool/examination/sections/motor_part.dart';
import 'package:neuropathy_grading_tool/examination/sections/pain_questionaire_part.dart';
import 'package:neuropathy_grading_tool/examination/sections/prick_part.dart';
import 'package:neuropathy_grading_tool/examination/sections/symptoms_part.dart';
import 'package:neuropathy_grading_tool/examination/sections/vibration_part.dart';

/// A list of identifiers in ``` RPNavigableOrderedTask examinationTask ``` that are considered part of the
/// total score for the examination.
///
/// The choice and contents of these are explained and elaborated on in the thesis report.
/// This list is used when calculating the score for the neuropathy examination, as well as for result export.
List<String> gradingTaskIdentifiers = [
  ...MotorStrings.values.map((e) => e.identifier),
  ...PrickStrings.values.map((e) => e.identifier),
  symptomsStep.identifier,
  ...VibrationStrings.values.map((e) => e.identifier)
];

/// A list of identifiers in ``` RPNavigableOrderedTask examinationTask ``` that make up the pain questionnaire score.
/// They follow the questions (and answers) from the DN4 questionnaire for neuropathic pain.
///
/// This list is used to calculate pain score part of the result screen, as well as provide identifiers for the export file.
List<String> painStepIdentifiers =
    painStepList.map((e) => e.identifier).toList();
