import 'package:neuropathy_grading_tool/survey/motor_part.dart';
import 'package:neuropathy_grading_tool/survey/pain_questionaire_part.dart';
import 'package:neuropathy_grading_tool/survey/prick_part.dart';
import 'package:neuropathy_grading_tool/survey/symptoms_part.dart';
import 'package:neuropathy_grading_tool/survey/vibration_part.dart';

List<String> gradingTaskIdentifiers = [
  ...MotorStrings.values.map((e) => e.identifier),
  ...PrickStrings.values.map((e) => e.identifier),
  symptomsStep.identifier,
  ...VibrationStrings.values.map((e) => e.identifier)
];

List<String> painStepIdentifiers =
    painStepList.map((e) => e.identifier).toList();
