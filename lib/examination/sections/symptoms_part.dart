import 'package:neuropathy_grading_tool/examination/steps/rp_choice_question_step.dart';
import 'package:research_package/model.dart';

List<RPChoice> _symptomsChoiceList = [
  RPChoice(text: 'symptoms.choice-1', value: 0),
  RPChoice(text: 'symptoms.choice-2', value: 1),
  RPChoice(text: 'symptoms.choice-3', value: 2),
  RPChoice(text: 'symptoms.choice-4', value: 3),
  RPChoice(text: 'symptoms.choice-5', value: 4),
];

RPChoiceAnswerFormat _symptomsAnswerFormat = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice,
    choices: _symptomsChoiceList);

RPChoiceQuestionStep symptomsStep = RPChoiceQuestionStep(
  identifier: 'general_symptoms',
  answerFormat: _symptomsAnswerFormat,
  title: 'symptoms.text-1',
  text: 'symptoms.text-2',
);
