import 'package:json_annotation/json_annotation.dart';
import 'package:research_package/research_package.dart';

import 'package:neuropathy_grading_tool/ui/examination/steps/rpui_vibration_step.dart';

/// Class representing all vibration part steps in the examination.
///
/// It is represented by [RPUIVibrationStep].
/// It's layout is determined by the presence of [vibrationSection].
/// If it is not null, the step will have a button enabling vibrations.
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
