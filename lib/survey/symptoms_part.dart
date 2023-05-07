import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neuro_planner/step/steps/rp_choice_question_step.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';
import 'package:research_package/model.dart';
//TODO: Localize

List<RPChoice> _symptomsChoiceList = [
  RPChoice(text: 'No symptoms', value: 0),
  RPChoice(text: 'In the toes', value: 1),
  RPChoice(text: 'Up to the ankle', value: 2),
  RPChoice(text: 'Up to the knee', value: 3),
  RPChoice(text: 'Beyond the knee', value: 4),
];

RPChoiceAnswerFormat _symptomsAnswerFormat = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice,
    choices: _symptomsChoiceList);

RPChoiceQuestionStep symptomsStep = RPChoiceQuestionStep(
  identifier: 'general_symptoms',
  answerFormat: _symptomsAnswerFormat,
  title:
      'In your day-to-day life, do you notice any symptoms in your legs or feet?',
  text:
      'Examples of symptoms are numbness, pain, or other unexpected sensations.',
);
