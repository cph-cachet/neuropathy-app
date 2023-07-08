import 'package:neuropathy_grading_tool/examination/steps/rp_choice_question_step.dart';
import 'package:research_package/model.dart';

/// List of [RPChoice] objects that represent the symptoms choices.
List<RPChoice> _symptomsChoiceList = [
  RPChoice(text: 'symptoms.choice-1', value: 0),
  RPChoice(text: 'symptoms.choice-2', value: 1),
  RPChoice(text: 'symptoms.choice-3', value: 2),
  RPChoice(text: 'symptoms.choice-4', value: 3),
  RPChoice(text: 'symptoms.choice-5', value: 4),
];

/// The answer format for the symptoms question.
RPChoiceAnswerFormat _symptomsAnswerFormat = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice,
    choices: _symptomsChoiceList);

/// The first step in the examination.
/// This question is a single choice question.
/// It asks the patient if they experience symptoms like numbness, pain, etc.
/// The answer choices are defined in [_symptomsChoiceList] and specify the areas
/// of the body where the patient experiences symptoms.
RPChoiceQuestionStep symptomsStep = RPChoiceQuestionStep(
  identifier: 'general_symptoms',
  answerFormat: _symptomsAnswerFormat,
  title: 'symptoms.text-1',
  text: 'symptoms.text-2',
);
