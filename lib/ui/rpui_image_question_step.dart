import '../step/steps/rp_image_question_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:research_package/research_package.dart';

import '../utils/themes/text_styles.dart';

class RPUIImageQuestionStep extends StatefulWidget {
  final RPImageQuestionStep step;

  const RPUIImageQuestionStep(this.step, {super.key});

  @override
  RPUIImageQuestionStepState createState() => RPUIImageQuestionStepState();
}

class RPUIImageQuestionStepState extends State<RPUIImageQuestionStep>
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
      case RPIntegerAnswerFormat:
        return RPUIIntegerQuestionBody((answerFormat as RPIntegerAnswerFormat),
            (result) {
          currentQuestionBodyResult = result;
        });
      case RPChoiceAnswerFormat:
        return RPUIChoiceQuestionBody((answerFormat as RPChoiceAnswerFormat),
            (result) {
          currentQuestionBodyResult = result;
        });
      case RPSliderAnswerFormat:
        return RPUISliderQuestionBody((answerFormat as RPSliderAnswerFormat),
            (result) {
          currentQuestionBodyResult = result;
        });
      case RPImageChoiceAnswerFormat:
        return RPUIImageChoiceQuestionBody(
            (answerFormat as RPImageChoiceAnswerFormat), (result) {
          currentQuestionBodyResult = result;
        });
      case RPDateTimeAnswerFormat:
        return RPUIDateTimeQuestionBody(
            (answerFormat as RPDateTimeAnswerFormat), (result) {
          currentQuestionBodyResult = result;
        });
      case RPTextAnswerFormat:
        return RPUITextInputQuestionBody((answerFormat as RPTextAnswerFormat),
            (result) {
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
              Image.asset(widget.step.legImage.imagePath),
              const SizedBox.square(dimension: 16),
              Text(
                locale?.translate(widget.step.title) ?? widget.step.title,
                style: ThemeTextStyle.headline24sp,
                textAlign: TextAlign.center,
              ),
            ],
          )),
      // Text
      (widget.step.text == null)
          ? Container()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                locale?.translate(widget.step.text!) ?? widget.step.text!,
                style: ThemeTextStyle.regularIBM18sp,
                textAlign: TextAlign.center,
              ),
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
