// Pain
import 'package:flutter/material.dart';
import 'package:neuro_planner/step/steps/rp_toggle_question_step.dart';
import 'package:neuro_planner/ui/widgets/neuropathy_icons.dart';
import 'package:research_package/research_package.dart';

import '../step/steps/rp_choice_question_step.dart';
import '../step/steps/rp_pain_slider_question_step.dart';

List<RPStep> painStepList = [
  painSlider,
  pain1,
  pain2,
  pain3,
  pain4,
];

//------------------------- common -------------------------
List<RPChoice> painYesNo = [
  RPChoice(text: 'common.yes', value: 1),
  RPChoice(text: 'common.no', value: 0)
];

RPChoiceAnswerFormat painYesNoFormat = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: painYesNo);

// ------------------------- Skip section screen -------------------------
RPToggleQuestionStep skipPainStep = RPToggleQuestionStep(
    identifier: 'skipPainID',
    title: 'pain-skip.title',
    answerFormat: painYesNoFormat);

// ------------------------- Pain slider -------------------------
RPPainSliderQuestionStep painSlider = RPPainSliderQuestionStep(
    identifier: 'painSlider',
    title: 'pain-0.title',
    answerFormat:
        RPSliderAnswerFormat(minValue: 0, maxValue: 100, divisions: 100));

// ------------------------- PAIN 1 -------------------------
List<String> _pain1ChoicesStrings = [
  'pain-1.choice-1',
  'pain-1.choice-2',
  'pain-1.choice-3',
];

Map<String, IconData> pain1Icons = {
  'pain-1.choice-1': NeuropathyIcons.fire,
  'pain-1.choice-2': NeuropathyIcons.cold,
  'pain-1.choice-3': Icons.bolt,
};

RPChoiceQuestionStep pain1 = RPChoiceQuestionStep(
    identifier: 'pain1',
    title: 'pain-1.title',
    answerFormat: RPChoiceAnswerFormat(
        answerStyle: RPChoiceAnswerStyle.MultipleChoice,
        choices:
            _choiceFactory(text: _pain1ChoicesStrings, addNoneOfAbove: true)));

// ------------------------- PAIN 2 -------------------------
List<String> _pain2ChoicesStrings = [
  'pain-2.choice-1',
  'pain-2.choice-2',
  'pain-2.choice-3',
  'pain-2.choice-4',
];

Map<String, IconData> pain2Icons = {
  'pain-2.choice-1': NeuropathyIcons.feather,
  'pain-2.choice-2': NeuropathyIcons.pin,
  'pain-2.choice-3': NeuropathyIcons.wave,
  'pain-2.choice-4': NeuropathyIcons.itching,
};

RPChoiceQuestionStep pain2 = RPChoiceQuestionStep(
    identifier: 'pain2',
    title: 'pain-2.title',
    answerFormat: RPChoiceAnswerFormat(
        answerStyle: RPChoiceAnswerStyle.MultipleChoice,
        choices:
            _choiceFactory(text: _pain2ChoicesStrings, addNoneOfAbove: true)));

// ------------------------- PAIN 3 -------------------------
List<String> pain3ChoicesStrings = [
  'pain-3.choice-1',
  'pain-3.choice-2',
];

RPChoiceQuestionStep pain3 = RPChoiceQuestionStep(
    identifier: 'pain3',
    title: 'pain-3.title',
    answerFormat: RPChoiceAnswerFormat(
        answerStyle: RPChoiceAnswerStyle.MultipleChoice,
        choices:
            _choiceFactory(text: pain3ChoicesStrings, addNoneOfAbove: true)));

// ------------------------- PAIN 4 -------------------------
RPToggleQuestionStep pain4 = RPToggleQuestionStep(
    identifier: 'pain4',
    title: 'pain-4.title-1',
    text: 'pain-4.title-2',
    answerFormat: painYesNoFormat);

List<RPChoice> _choiceFactory(
    {required List<String> text, bool addNoneOfAbove = false}) {
  List<RPChoice> res = text.map((e) => RPChoice(text: e, value: 1)).toList();
  if (addNoneOfAbove) {
    res.add(RPChoice(text: 'common.none-of-the-above', value: 0));
  }
  return res;
}
