import 'package:json_annotation/json_annotation.dart';
import 'package:research_package/research_package.dart';

import 'RPUIPainSliderQuestionStep.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPPainSliderQuestionStep extends RPStep {
  RPAnswerFormat answerFormat;

  RPPainSliderQuestionStep({
    required super.identifier,
    required super.title,
    super.text,
    super.optional,
    required this.answerFormat,
  });

  @override
  get stepWidget => RPUIPainSliderQuestionStep(this);

  @override // TODO: implement fromJsonFunction
  Function get fromJsonFunction => super.fromJsonFunction;
  // TODO: factory function and Map
}
