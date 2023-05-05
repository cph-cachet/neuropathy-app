import 'package:json_annotation/json_annotation.dart';
import 'package:research_package/research_package.dart';

import '../../ui/rpui_image_question_step.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPImageQuestionStep extends RPStep {
  RPAnswerFormat answerFormat;

  LegImage legImage;

  RPImageQuestionStep({
    required super.identifier,
    required super.title,
    super.text,
    required this.legImage,
    super.optional,
    required this.answerFormat,
  });

  @override
  get stepWidget => RPUIImageQuestionStep(this);

  @override // TODO: implement fromJsonFunction
  Function get fromJsonFunction => super.fromJsonFunction;
  // TODO: factory function and Map
}

enum LegImage {
  leftLeg1('assets/LeftLeg1.png'),
  leftLeg2('assets/LeftLeg2.png'),
  leftLeg3('assets/LeftLeg3.png'),
  leftLeg4('assets/LeftLeg4.png'),
  leftLeg5('assets/LeftLeg5.png'),
  leftLeg6('assets/LeftLeg6.png'),
  rightLeg1('assets/RightLeg1.png'),
  rightLeg2('assets/RightLeg2.png'),
  rightLeg3('assets/RightLeg3.png'),
  rightLeg4('assets/RightLeg4.png'),
  rightLeg5('assets/RightLeg5.png'),
  rightLeg6('assets/RightLeg6.png'),
  leftGreatToe('assets/LeftGreatToe.png'),
  rightGreatToe('assets/RightGreatToe.png');

  const LegImage(this.imagePath);
  final String imagePath;
}
