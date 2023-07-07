import 'package:json_annotation/json_annotation.dart';
import 'package:research_package/research_package.dart';

import 'package:neuropathy_grading_tool/ui/examination/steps/rpui_image_question_step.dart';

/// Class representing an image question step in the examination. It is used for the prick and motor parts.
///
/// It is represented by [RPUIImageQuestionStep], and follows the same schema, taking arguments for the displayed image,
/// instructional text displayed bellow the image, and bottomSheet contents.
/// Takes [RPChoiceAnswerFormat] as the answer format which is always presented as a [ToggleButton].
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPImageQuestionStep extends RPStep {
  RPChoiceAnswerFormat answerFormat;

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
}
