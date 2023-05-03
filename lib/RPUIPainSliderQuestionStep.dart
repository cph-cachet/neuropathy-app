import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:research_package/research_package.dart';

import 'RPPainSliderQuestionStep.dart';
import 'RPUIPainSliderQuestionBody.dart';

class RPUIPainSliderQuestionStep extends StatefulWidget {
  final RPPainSliderQuestionStep step;

  const RPUIPainSliderQuestionStep(this.step, {super.key});

  @override
  RPUIPainSliderQuestionStepState createState() =>
      RPUIPainSliderQuestionStepState();
}

class RPUIPainSliderQuestionStepState extends State<RPUIPainSliderQuestionStep>
    with CanSaveResult {
  // Dynamic because we don't know what value the RPChoice will have
  dynamic _currentQuestionBodyResult;
  late RPStepResult result;

  set currentQuestionBodyResult(dynamic currentQuestionBodyResult) {
    _currentQuestionBodyResult = currentQuestionBodyResult;
    createAndSendResult();
    if (_currentQuestionBodyResult != null) {
      blocQuestion.sendReadyToProceed(true);
    } else {
      blocQuestion.sendReadyToProceed(false);
    }
  }

  void skipQuestion() {
    FocusManager.instance.primaryFocus?.unfocus();
    blocTask.sendStatus(RPStepStatus.Finished);
    currentQuestionBodyResult = null;
  }

  @override
  void initState() {
    // Instantiating the result object here to start the time counter (startDate)
    super.initState();

    result = RPStepResult(
        identifier: widget.step.identifier,
        questionTitle: widget.step.title,
        answerFormat: widget.step.answerFormat);
    blocQuestion.sendReadyToProceed(false);
  }

  // Returning the according step body widget based on the answerFormat of the step
  Widget stepBody(RPAnswerFormat answerFormat) {
    switch (answerFormat.runtimeType) {
      case RPSliderAnswerFormat:
        return RPUIPainSliderQuestionBody(
            (answerFormat as RPSliderAnswerFormat), (result) {
          currentQuestionBodyResult = result;
        });
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    RPLocalizations? locale = RPLocalizations.of(context);
    return SafeArea(
        child: ListView(padding: const EdgeInsets.all(8), children: [
      // Image and title
      Padding(
          padding: const EdgeInsets.only(bottom: 24, left: 8, right: 8),
          child: Column(
            children: [
              const SizedBox.square(dimension: 16),
              Text(locale?.translate(widget.step.title) ?? widget.step.title,
                  style: Theme.of(context).textTheme.titleLarge),
            ],
          )),
      // Text
      (widget.step.text == null)
          ? Container()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  locale?.translate(widget.step.text!) ?? widget.step.text!),
            ),
      // Step body
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: stepBody(widget.step.answerFormat),
      ),
    ]));
  }

  @override
  void createAndSendResult() {
    result.questionTitle = widget.step.title;
    result.setResult(_currentQuestionBodyResult);
    blocTask.sendStepResult(result);
  }
}
