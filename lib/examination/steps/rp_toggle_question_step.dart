import 'package:json_annotation/json_annotation.dart';
import 'package:research_package/research_package.dart';

import 'package:neuropathy_grading_tool/ui/examination/steps/rpui_toggle_question_step.dart';

/// Class representing a toggle question step in the examination, where the only Widgets in the step are [title], optional [text] and a [ToggleButton].
///
/// It is represented by [RPUIToggleQuestionStep]. The layout is determined by the presence of [text].
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPToggleQuestionStep extends RPStep {
  RPAnswerFormat answerFormat;

  RPToggleQuestionStep({
    required super.identifier,
    required super.title,
    super.text,
    super.optional,
    required this.answerFormat,
  });

  @override
  get stepWidget => RPUIToggleQuestionStep(this);
}
