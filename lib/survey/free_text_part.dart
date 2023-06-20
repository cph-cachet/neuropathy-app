import 'package:neuro_planner/step/steps/rp_free_text_step.dart';
import 'package:research_package/research_package.dart';

const String _freeTextTitle = 'free-text.title';
const String _freeTextText = 'free-text.text';

RPTextAnswerFormat freeTextAnswerFormat = RPTextAnswerFormat();

RPFreeTextStep freeTextStep = RPFreeTextStep(
    identifier: 'free_text_step',
    title: _freeTextTitle,
    text: _freeTextText,
    answerFormat: freeTextAnswerFormat);
