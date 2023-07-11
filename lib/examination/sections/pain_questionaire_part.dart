import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/examination/steps/rp_toggle_question_step.dart';
import 'package:neuropathy_grading_tool/utils/neuropathy_icons.dart';
import 'package:research_package/research_package.dart';

import 'package:neuropathy_grading_tool/examination/steps/rp_choice_question_step.dart';
import 'package:neuropathy_grading_tool/examination/steps/rp_pain_slider_question_step.dart';

/// List of [RPStep] objects that represent the pain section.
List<RPStep> painStepList = [
  painSlider,
  pain1,
  pain2,
  pain3,
  pain4,
];

//------------------------- common -------------------------
/// List of [RPChoice] objects that represent the yes/no choices in the pain section.
/// [value] decides how many points each option adds to the pain score (not total score).
List<RPChoice> painYesNo = [
  RPChoice(text: 'common.yes', value: 1),
  RPChoice(text: 'common.no', value: 0)
];

/// The answer format for the yes/no choices in the pain section.
RPChoiceAnswerFormat painYesNoFormat = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: painYesNo);

// ------------------------- Skip section screen -------------------------
RPToggleQuestionStep skipPainStep = RPToggleQuestionStep(
    identifier: 'skipPainID',
    title: 'pain-skip.title',
    answerFormat: painYesNoFormat);

// ------------------------- Pain slider -------------------------
/// A step in the pain section. This question is a slider question.
/// It asks the user to rate their pain on a scale from 0 to 100.
RPPainSliderQuestionStep painSlider = RPPainSliderQuestionStep(
    identifier: 'painSlider',
    title: 'pain-0.title',
    answerFormat:
        RPSliderAnswerFormat(minValue: 0, maxValue: 100, divisions: 100));

// ------------------------- PAIN 1 -------------------------
/// List of pain 1 choice text strings.
List<String> _pain1ChoicesStrings = [
  'pain-1.choice-1',
  'pain-1.choice-2',
  'pain-1.choice-3',
];

/// Map of pain 1 choice text strings to their icons.
/// The icons are displayed in the results page next to the choice text.
Map<String, IconData> pain1Icons = {
  'pain-1.choice-1': NeuropathyIcons.fire,
  'pain-1.choice-2': NeuropathyIcons.cold,
  'pain-1.choice-3': Icons.bolt,
};

/// A step in the pain section. This question is a multiple choice question.
/// It asks the user to select the characteristics of pain they are experiencing.
RPChoiceQuestionStep pain1 = RPChoiceQuestionStep(
    identifier: 'pain1',
    title: 'pain-1.title',
    answerFormat: RPChoiceAnswerFormat(
        answerStyle: RPChoiceAnswerStyle.MultipleChoice,
        choices:
            _choiceFactory(text: _pain1ChoicesStrings, addNoneOfAbove: true)));

// ------------------------- PAIN 2 -------------------------
/// List of pain 2 choice text strings.
List<String> _pain2ChoicesStrings = [
  'pain-2.choice-1',
  'pain-2.choice-2',
  'pain-2.choice-3',
  'pain-2.choice-4',
];

/// Map of pain 2 choice text strings to their icons.
/// The icons are displayed in the results page next to the choice text.
Map<String, IconData> pain2Icons = {
  'pain-2.choice-1': NeuropathyIcons.feather,
  'pain-2.choice-2': NeuropathyIcons.pin,
  'pain-2.choice-3': NeuropathyIcons.wave,
  'pain-2.choice-4': NeuropathyIcons.itching,
};

/// A step in the pain section. This question is a multiple choice question.
/// It asks the user to select the symptoms their pain can be associated with.
RPChoiceQuestionStep pain2 = RPChoiceQuestionStep(
    identifier: 'pain2',
    title: 'pain-2.title',
    answerFormat: RPChoiceAnswerFormat(
        answerStyle: RPChoiceAnswerStyle.MultipleChoice,
        choices:
            _choiceFactory(text: _pain2ChoicesStrings, addNoneOfAbove: true)));

// ------------------------- PAIN 3 -------------------------
/// List of pain 3 choice text strings.
List<String> pain3ChoicesStrings = [
  'pain-3.choice-1',
  'pain-3.choice-2',
];

/// A step in the pain section. This question is a multiple choice question.
/// It asks the user to select if the pain is located in an area where the examination revealed.
/// decrease in sensitivity to pinprick or touch.
RPChoiceQuestionStep pain3 = RPChoiceQuestionStep(
    identifier: 'pain3',
    title: 'pain-3.title',
    answerFormat: RPChoiceAnswerFormat(
        answerStyle: RPChoiceAnswerStyle.MultipleChoice,
        choices:
            _choiceFactory(text: pain3ChoicesStrings, addNoneOfAbove: true)));

// ------------------------- PAIN 4 -------------------------
/// A step in the pain section. This question is a yes/no question.
/// It asks the user if the pain is provoked or increased by stroking.
RPToggleQuestionStep pain4 = RPToggleQuestionStep(
    identifier: 'pain4',
    title: 'pain-4.title-1',
    text: 'pain-4.title-2',
    answerFormat: painYesNoFormat);

// ------------------------- Helper functions -------------------------
/// Helper function that creates a list of [RPChoice] objects from a list of strings for the purpose of multiple choice questions.
/// Each selected choice adds [value] points to the pain score (not total score).
/// If [addNoneOfAbove] is true, a choice with the text 'common.none-of-the-above' and [value] 0 is added to the list.
List<RPChoice> _choiceFactory(
    {required List<String> text, bool addNoneOfAbove = false}) {
  List<RPChoice> res = text.map((e) => RPChoice(text: e, value: 1)).toList();
  if (addNoneOfAbove) {
    res.add(RPChoice(text: 'common.none-of-the-above', value: 0));
  }
  return res;
}
