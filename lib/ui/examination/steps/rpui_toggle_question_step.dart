//import 'RPPrickQuestionStep.dart';
import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/ui/widgets/semi_bold_text.dart';
import 'package:neuropathy_grading_tool/ui/widgets/toggle_button.dart';
import 'package:research_package/research_package.dart';

import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/examination/steps/rp_toggle_question_step.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';

class RPUIToggleQuestionStep extends StatefulWidget {
  final RPToggleQuestionStep step;

  const RPUIToggleQuestionStep(this.step, {super.key});

  @override
  RPUIToggleQuestionStepState createState() => RPUIToggleQuestionStepState();
}

class RPUIToggleQuestionStepState extends State<RPUIToggleQuestionStep>
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      // Image and title
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: semiBoldText(
            Languages.of(context)!.translate(widget.step.title),
            AppTextStyle.headline24sp,
            TextAlign.center,
          )),
      // Text
      (widget.step.text == null)
          ? Container()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: Text(
                Languages.of(context)!.translate(widget.step.text!),
                style: AppTextStyle.headline24sp,
                textAlign: TextAlign.center,
              ),
            ),
      // Step body
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ToggleButton(
            answerFormat: widget.step.answerFormat as RPChoiceAnswerFormat,
            onPressed: (result) {
              currentQuestionBodyResult = result;
            }),
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
