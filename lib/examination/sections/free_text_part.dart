import 'package:neuropathy_grading_tool/examination/steps/rp_free_text_step.dart';
import 'package:research_package/research_package.dart';

const String _freeTextTitle = 'free-text.title';
const String _freeTextText = 'free-text.text';

RPTextAnswerFormat freeTextAnswerFormat = RPTextAnswerFormat();

/// A final step for the user to enter any additional information.
///
/// It is not required to fill out this step.
/// The [freeTextAnswerFormat] accepts any text input from the user.
/// It is part of the examination export.
RPFreeTextStep freeTextStep = RPFreeTextStep(
    identifier: 'free_text_step',
    title: _freeTextTitle,
    text: _freeTextText,
    answerFormat: freeTextAnswerFormat);
