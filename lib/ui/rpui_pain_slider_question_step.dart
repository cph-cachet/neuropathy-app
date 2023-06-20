import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:research_package/research_package.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';
import '../languages.dart';
import '../step/steps/rp_pain_slider_question_step.dart';
import 'QuestionBody/rpui_pain_slider_question_body.dart';

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
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      // Image and title
      Padding(
          padding: const EdgeInsets.only(bottom: 24, left: 8, right: 8),
          child: Column(
            children: [
              const SizedBox.square(dimension: 16),
              Text(Languages.of(context)!.translate(widget.step.title),
                  style: ThemeTextStyle.headline24sp,
                  textAlign: TextAlign.center),
            ],
          )),
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
