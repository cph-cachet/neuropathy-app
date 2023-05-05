import 'package:flutter/material.dart';
import 'package:research_package/research_package.dart';

import 'package:neuro_planner/ui/QuestionBody/rpui_vibration_body_with_button.dart';
import 'package:neuro_planner/ui/widgets/toggle_button.dart';

import '../step/steps/rp_vibration_step.dart';

// TODO: Decide if vertical padding is more useful than alignment
class RPUIVibrationStep extends StatefulWidget {
  final RPVibrationStep vibrationStep;
  const RPUIVibrationStep(this.vibrationStep, {super.key});

  @override
  RPUIVibrationStepState createState() => RPUIVibrationStepState();
}

class RPUIVibrationStepState extends State<RPUIVibrationStep>
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
        identifier: widget.vibrationStep.identifier,
        questionTitle: widget.vibrationStep.title,
        answerFormat: widget.vibrationStep.answerFormat);
    blocQuestion.sendReadyToProceed(false);
  }

  Widget stepBody(
      {required RPVibrationStep vibrationStep, required Widget button}) {
    return vibrationStep.vibrationSection != null &&
            vibrationStep.vibrationSection!.isNotEmpty
        ? RPUIVibrationBodyWithButton(
            vibrationStep: vibrationStep, toggleButton: button)
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: stepBody(
          vibrationStep: widget.vibrationStep,
          button: ToggleButton(
              answerFormat:
                  widget.vibrationStep.answerFormat as RPChoiceAnswerFormat,
              onPressed: (result) {
                currentQuestionBodyResult = result;
              })),
    );
  }

  @override
  void createAndSendResult() {
    result.questionTitle = widget.vibrationStep.title;
    result.setResult(_currentQuestionBodyResult);
    blocTask.sendStepResult(result);
  }
}
