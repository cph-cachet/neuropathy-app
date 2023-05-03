import 'package:json_annotation/json_annotation.dart';
import 'package:research_package/research_package.dart';

import 'RPUIPrickQuestionStep.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPPrickQuestionStep extends RPStep {
  RPAnswerFormat answerFormat;

  PrickSection prickSection;

  RPPrickQuestionStep({
    required super.identifier,
    required super.title,
    super.text,
    required this.prickSection,
    super.optional,
    required this.answerFormat,
  });

  @override
  get stepWidget => RPUIPrickQuestionStep(this);

  @override // TODO: implement fromJsonFunction
  Function get fromJsonFunction => super.fromJsonFunction;
  // TODO: factory function and Map
}

enum PrickSection {
  Left1,
  Left2,
  Left3,
  Left4,
  Left5,
  Left6,
  Right1,
  Right2,
  Right3,
  Right4,
  Right5,
  Right6
}
