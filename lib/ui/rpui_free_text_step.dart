import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neuro_planner/step/steps/rp_free_text_step.dart';
import 'package:research_package/research_package.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';

class RPUIFreeTextStep extends StatefulWidget {
  final RPFreeTextStep step;

  const RPUIFreeTextStep(this.step, {super.key});

  @override
  RPUIFreeTextStepState createState() => RPUIFreeTextStepState();
}

class RPUIFreeTextStepState extends State<RPUIFreeTextStep> with CanSaveResult {
  // Dynamic because we don't know what value the RPChoice will have
  dynamic _currentQuestionBodyResult;
  late RPStepResult result;

  set currentQuestionBodyResult(dynamic currentQuestionBodyResult) {
    // Empty or only whitespace counts as no answer
    if ((currentQuestionBodyResult == null) |
        (currentQuestionBodyResult.toString().trim() == '')) {
      _currentQuestionBodyResult = null;
    } else {
      _currentQuestionBodyResult = currentQuestionBodyResult;
    }
    createAndSendResult();
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

    currentQuestionBodyResult = null;
    blocQuestion.sendReadyToProceed(true);
  }

  // Returning the according step body widget based on the answerFormat of the step
  Widget stepBody(RPAnswerFormat answerFormat) {
    switch (answerFormat.runtimeType) {
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
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Title
        Padding(
            padding: const EdgeInsets.only(bottom: 24, left: 8, right: 8),
            child: Column(
              children: [
                const SizedBox.square(dimension: 16),
                Text(widget.step.title,
                    style: ThemeTextStyle.headline24sp,
                    textAlign: TextAlign.center),
              ],
            )),
        if (widget.step.text != null)
          Text(
            widget.step.text!,
            style: ThemeTextStyle.regularIBM18sp,
            textAlign: TextAlign.center,
          ),
        // Step body
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: stepBody(widget.step.answerFormat),
        ),
      ]),
    ));
  }

  @override
  void createAndSendResult() {
    result.questionTitle = widget.step.title;
    result.setResult(_currentQuestionBodyResult);
    blocTask.sendStepResult(result);
  }
}
