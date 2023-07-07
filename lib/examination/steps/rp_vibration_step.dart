import 'package:json_annotation/json_annotation.dart';
import 'package:research_package/research_package.dart';

import 'package:neuropathy_grading_tool/ui/rpui_vibration_step.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPVibrationStep extends RPStep {
  String? vibrationSection;
  RPAnswerFormat answerFormat;

  RPVibrationStep({
    required super.identifier,
    required super.title,
    super.text,
    this.vibrationSection,
    required this.answerFormat,
  });

  @override
  get stepWidget => RPUIVibrationStep(this);
}
