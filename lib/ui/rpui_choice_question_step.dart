import 'package:flutter/material.dart';
import 'package:neuro_planner/step/steps/rp_choice_question_step.dart';
import 'package:neuro_planner/ui/widgets/choice_selector.dart';
import 'package:neuro_planner/utils/spacing.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 72),
              child: Text(
                widget.step.title,
                style: widget.step.textStyle ?? ThemeTextStyle.headline24sp,
                textAlign: TextAlign.center,
              ),
            ),
            if (widget.step.text != null) verticalSpacing(24),
            if (widget.step.text != null)
              Text(
                widget.step.text!,
                style: widget.step.textStyle ?? ThemeTextStyle.headline24sp,
                textAlign: TextAlign.center,
              ),
            Column(
              children: [
                if (widget.step.answerFormat.answerStyle ==
                    RPChoiceAnswerStyle.MultipleChoice) ...[
                  Text(
                    'Check all that apply',
                    style: ThemeTextStyle.regularIBM14sp,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpacing(16)
                ],
                ChoiceSelector(
                    onResultChange: (result) {
                      currentQuestionBodyResult = result;
                    },
                    answerFormat: widget.step.answerFormat)
              ],
            )
          ],
        ),
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
