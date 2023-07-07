import 'package:neuropathy_grading_tool/ui/examination/steps/rpui_choice_question_step.dart';
import 'package:research_package/model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPChoiceQuestionStep extends RPStep {
  final RPChoiceAnswerFormat answerFormat;

  RPChoiceQuestionStep({
    super.text,
    required super.identifier,
    required this.answerFormat,
    required super.title,
  });

  @override
  get stepWidget => RPUIChoiceQuestionStep(this);
}
