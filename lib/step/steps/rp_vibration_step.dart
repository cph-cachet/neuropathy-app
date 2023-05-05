import 'package:json_annotation/json_annotation.dart';
import 'package:research_package/research_package.dart';

import '../../ui/rpui_vibration_test_body.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPVibrationStep extends RPStep {
  VibrationSection vibrationSection;
  RPAnswerFormat answerFormat;

  RPVibrationStep({
    required super.identifier,
    required super.title,
    super.text,
    required this.vibrationSection,
    required this.answerFormat,
  });

  @override
  get stepWidget => RPUIVibrationStep(this);

  @override
  Function get fromJsonFunction => super.fromJsonFunction;
}

enum VibrationSection {
  leftToe('assets/images/steps/vibration/left_toe.png');

  const VibrationSection(this.imagePath);
  final String imagePath;
}
