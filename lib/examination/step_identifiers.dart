import 'package:neuropathy_grading_tool/examination/motor_part.dart';
import 'package:neuropathy_grading_tool/examination/pain_questionaire_part.dart';
import 'package:neuropathy_grading_tool/examination/prick_part.dart';
import 'package:neuropathy_grading_tool/examination/symptoms_part.dart';
import 'package:neuropathy_grading_tool/examination/vibration_part.dart';

List<String> gradingTaskIdentifiers = [
  ...MotorStrings.values.map((e) => e.identifier),
  ...PrickStrings.values.map((e) => e.identifier),
  symptomsStep.identifier,
  ...VibrationStrings.values.map((e) => e.identifier)
];

List<String> painStepIdentifiers =
    painStepList.map((e) => e.identifier).toList();
