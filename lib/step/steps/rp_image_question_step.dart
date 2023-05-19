import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:research_package/research_package.dart';

import '../../ui/rpui_image_question_step.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPImageQuestionStep extends RPStep {
  RPAnswerFormat answerFormat;

  List<String> textContent;
  String imagePath;
  String bottomSheetTitle;
  List<String> bottomSheetTextContent;

  RPImageQuestionStep({
    required super.identifier,
    required super.title,
    required this.textContent,
    required this.imagePath,
    required this.bottomSheetTitle,
    required this.bottomSheetTextContent,
    super.optional,
    required this.answerFormat,
  });

  @override
  get stepWidget => RPUIImageQuestionStep(this);

  @override // TODO: implement fromJsonFunction
  Function get fromJsonFunction => super.fromJsonFunction;
  // TODO: factory function and Map
}
