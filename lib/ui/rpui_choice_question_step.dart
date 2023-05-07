import 'package:flutter/material.dart';
import 'package:neuro_planner/step/steps/rp_choice_question_step.dart';
import 'package:research_package/model.dart';

class RPUIChoiceQuestionStep extends StatefulWidget {
  final RPChoiceQuestionStep step;
  //final Function(dynamic) onResultChange;

  const RPUIChoiceQuestionStep(this.step, {super.key});

  @override
  RPUIChoiceQuestionStepState createState() => RPUIChoiceQuestionStepState();
}

class RPUIChoiceQuestionStepState extends State<RPUIChoiceQuestionStep>
    with CanSaveResult {
  late RPStepResult result;
  dynamic _currentQuestionBodyResult;

  set currentQuestionBodyResult(dynamic currentQuestionBodyResult) {
    _currentQuestionBodyResult = currentQuestionBodyResult;
    createAndSendResult();
    if (_currentQuestionBodyResult != null) {
      blocQuestion.sendReadyToProceed(true);
    } else {
      blocQuestion.sendReadyToProceed(false);
    }
  }

  @override
  void initState() {
    super.initState();
    result = RPStepResult(
        identifier: widget.step.identifier,
        questionTitle: widget.step.title,
        answerFormat: widget.step.answerFormat);
    blocQuestion.sendReadyToProceed(false);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [],
      ),
    );
  }

  @override
  void createAndSendResult() {
    result.questionTitle = widget.step.title;
    result.setResult(_currentQuestionBodyResult);
    blocTask.sendStepResult(result);
  }
}
