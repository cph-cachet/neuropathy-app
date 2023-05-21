import 'package:json_annotation/json_annotation.dart';
import 'package:neuro_planner/ui/rpui_free_text_step.dart';
import 'package:research_package/research_package.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPFreeTextStep extends RPStep {
  RPAnswerFormat answerFormat;

  RPFreeTextStep({
    required super.identifier,
    required super.title,
    super.text,
    super.optional,
    required this.answerFormat,
  });

  @override
  get stepWidget => RPUIFreeTextStep(this);

  @override // TODO: implement fromJsonFunction
  Function get fromJsonFunction => super.fromJsonFunction;
  // TODO: factory function and Map
}
