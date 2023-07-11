import 'package:json_annotation/json_annotation.dart';
import 'package:research_package/research_package.dart';

import 'package:neuropathy_grading_tool/ui/examination/steps/rpui_pain_slider_question_step.dart';

/// Class representing a pain slider question step in the pain section of examination.
///
/// It is represented by [RPUIPainSliderQuestionStep], displaying a slider with a scale from 0 to 100, without a value pointer.
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
}
