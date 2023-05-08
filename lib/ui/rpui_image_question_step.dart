import 'package:neuro_planner/ui/widgets/bottom_sheet_button.dart';
import 'package:neuro_planner/utils/spacing.dart';

import '../step/steps/rp_image_question_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:research_package/research_package.dart';

import '../utils/themes/text_styles.dart';
import 'widgets/toggle_button.dart';

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
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        // Image and title
        Column(
          children: [
            ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.35),
                child: Image.asset(widget.step.imagePath)),
            verticalSpacing(16),
            Text(
              locale?.translate(widget.step.title) ?? widget.step.title,
              style: ThemeTextStyle.headline24sp,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Column(
          children: [
            // Text
            (widget.step.text == null)
                ? Container()
                : Text(
                    locale?.translate(widget.step.text!) ?? widget.step.text!,
                    style: widget.step.identifier.contains('prick')
                        ? ThemeTextStyle.regularIBM18sp
                        : ThemeTextStyle.headline24sp,
                    textAlign: TextAlign.center,
                  ),
            BottomSheetButton(
                icon: const Icon(
                  Icons.help_outline_rounded,
                  size: 20,
                ),
                label: 'More Information',
                bottomSheetTitle: widget.step.bottomSheetTitle,
                content: Text(
                  widget.step.bottomSheetText,
                  style: ThemeTextStyle.regularIBM20sp,
                  textAlign: TextAlign.justify,
                )),
          ],
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
