import 'package:neuro_planner/survey/motor_part.dart';
import 'package:neuro_planner/survey/prick_part.dart';
import 'package:neuro_planner/survey/symptoms_part.dart';
import 'package:neuro_planner/survey/vibration_part.dart';

List<String> gradingTaskIdentifiers = [
  ...MotorStrings.values.map((e) => e.identifier),
  ...PrickStrings.values.map((e) => e.identifier),
  symptomsStep.identifier,
  ...VibrationStrings.values.map((e) => e.identifier)
];

List<String> painTaskIdentifiers = [
  'painSlider',
  'pain1',
  'pain2',
  'pain3',
  'pain4'
];

enum TaskStepIdentifiers {
  motorLeftToe('motor_left_toe'),
  motorRightToe('motor_right_toe'),
  painSlider('pain_slider'),
  pain1('pain1'),
  pain2('pain2'),
  pain3('pain3'),
  pain4('pain4'),
  prickLeft1('prick_left_1'),
  prickLeft2('prick_left_2'),
  prickLeft3('prick_left_3'),
  prickLeft4('prick_left_4'),
  prickLeft5('prick_left_5'),
  prickLeft6('prick_left_6'),
  prickLeftAllodynia('prick_left_allodynia'),
  prickLeftHyperaesthesia('prick_left_hyper'),
  prickRight1('prick_right_1'),
  prickRight2('prick_right_2'),
  prickRight3('prick_right_3'),
  prickRight4('prick_right_4'),
  prickRight5('prick_right_5'),
  prickRight6('prick_right_6'),
  prickRightAllodynia('prick_right_allodynia'),
  prickRighttHyperaesthesia('prick_right_hyper'),
  symptoms('general_symptoms'),
  vibrationLetftToe('viration_left_toe'),
  vibrationLeftAnkle('viration_left_ankle'),
  vibrationLeftKnee('viration_left_knee'),
  vibrationRightToe('viration_right_toe'),
  vibrationRightAnkle('viration_right_ankle'),
  vibrationRightKnee('viration_right_knee');

  const TaskStepIdentifiers(this.identifier);
  final String identifier;
}
