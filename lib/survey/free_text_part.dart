//TODO: Localize

import 'package:neuro_planner/step/steps/rp_free_text_step.dart';
import 'package:research_package/research_package.dart';

const String _freeTextTitle = 'Closing comments';
const String _freeTextText =
    'Do you have any thought or comments that weren\'t addressed in the examination? If so, please write them below';

RPTextAnswerFormat freeTextAnswerFormat = RPTextAnswerFormat();

RPFreeTextStep freeTextStep = RPFreeTextStep(
    identifier: 'free_text_step',
    title: _freeTextTitle,
    text: _freeTextText,
    answerFormat: freeTextAnswerFormat);
