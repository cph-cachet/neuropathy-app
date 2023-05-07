// Pain
//TODO: localize
//TODO: identifiers in assets constants
import 'package:neuro_planner/step/steps/rp_toggle_question_step.dart';
import 'package:research_package/research_package.dart';

import '../step/steps/rp_choice_question_step.dart';
import '../step/steps/rp_pain_slider_question_step.dart';

List<RPStep> painStepList = [
  _painSlider,
  _pain1,
  _pain2,
  _pain3,
  _pain4,
];

//------------------------- common -------------------------
List<RPChoice> painYesNo = [
  RPChoice(text: 'yes', value: 1),
  RPChoice(text: 'no', value: 0)
];

RPChoiceAnswerFormat painYesNoFormat = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: painYesNo);

// ------------------------- Skip section screen -------------------------
RPToggleQuestionStep skipPainStep = RPToggleQuestionStep(
    identifier: 'skipPainID',
    title: 'Are you experiencing pain in your feet?',
    answerFormat: painYesNoFormat);

// ------------------------- Pain slider -------------------------
RPPainSliderQuestionStep _painSlider = RPPainSliderQuestionStep(
    identifier: 'painSlider',
    title: 'On the scale below,\nmark your pain level.',
    answerFormat:
        RPSliderAnswerFormat(minValue: 0, maxValue: 100, divisions: 100));

// ------------------------- PAIN 1 -------------------------
List<String> _pain1ChoicesStrings = [
  'Pain feels like burning',
  'Sensation of painful cold',
  'Pain feels like electric shocks',
];

RPChoiceQuestionStep _pain1 = RPChoiceQuestionStep(
    identifier: 'pain1',
    title:
        'Does your pain present one or more of the following characteristics?',
    answerFormat: RPChoiceAnswerFormat(
        answerStyle: RPChoiceAnswerStyle.MultipleChoice,
        choices:
            _choiceFactory(text: _pain1ChoicesStrings, addNoneOfAbove: true)));

// ------------------------- PAIN 2 -------------------------
List<String> _pain2ChoicesStrings = [
  'Tingling',
  'Pins and needles',
  'Numbness',
  'Itching',
];
RPChoiceQuestionStep _pain2 = RPChoiceQuestionStep(
    identifier: 'pain2',
    title: 'In the same area, is your pain associated to one or more symptoms?',
    answerFormat: RPChoiceAnswerFormat(
        answerStyle: RPChoiceAnswerStyle.MultipleChoice,
        choices:
            _choiceFactory(text: _pain2ChoicesStrings, addNoneOfAbove: true)));

// ------------------------- PAIN 3 -------------------------
List<String> _pain3ChoicesStrings = [
  'Decreased sensitivity to touch',
  'Decreased sensitivity to pricking',
];

RPChoiceQuestionStep _pain3 = RPChoiceQuestionStep(
    identifier: 'pain3',
    title: 'Is the pain located in an area where the examination unveiled:',
    answerFormat: RPChoiceAnswerFormat(
        answerStyle: RPChoiceAnswerStyle.MultipleChoice,
        choices:
            _choiceFactory(text: _pain3ChoicesStrings, addNoneOfAbove: true)));

// ------------------------- PAIN 4 -------------------------
RPToggleQuestionStep _pain4 = RPToggleQuestionStep(
    identifier: 'pain4',
    title:
        'Use your fingers to gently stroke the areas where the pain is present.\n\n\nIs the pain provoked or increased by the stroking?',
    answerFormat: painYesNoFormat);

List<RPChoice> _choiceFactory(
    {required List<String> text, bool addNoneOfAbove = false}) {
  List<RPChoice> res = text.map((e) => RPChoice(text: e, value: 1)).toList();
  if (addNoneOfAbove) res.add(RPChoice(text: 'None of the above', value: 0));
  return res;
}
