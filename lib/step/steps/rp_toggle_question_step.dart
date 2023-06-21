import 'package:json_annotation/json_annotation.dart';
import 'package:research_package/research_package.dart';

import '../../ui/rpui_toggle_question_step.dart';

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
