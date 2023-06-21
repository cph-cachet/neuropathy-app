import 'package:neuro_planner/survey/motor_part.dart';
import 'package:neuro_planner/survey/pain_questionaire_part.dart';
import 'package:neuro_planner/survey/prick_part.dart';
import 'package:neuro_planner/survey/symptoms_part.dart';
import 'package:neuro_planner/survey/vibration_part.dart';

List<String> gradingTaskIdentifiers = [
  ...MotorStrings.values.map((e) => e.identifier),
  ...PrickStrings.values.map((e) => e.identifier),
  symptomsStep.identifier,
  ...VibrationStrings.values.map((e) => e.identifier)
];

List<String> painStepIdentifiers =
    painStepList.map((e) => e.identifier).toList();
