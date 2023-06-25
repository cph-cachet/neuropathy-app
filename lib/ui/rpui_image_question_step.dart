import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/ui/widgets/bottom_sheet_button.dart';
import 'package:neuropathy_grading_tool/ui/widgets/semi_bold_text.dart';
import 'package:neuropathy_grading_tool/utils/spacing.dart';

import 'package:neuropathy_grading_tool/step/steps/rp_image_question_step.dart';
import 'package:flutter/material.dart';
import 'package:research_package/research_package.dart';

import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';
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
      case RPChoiceAnswerFormat:
        return RPUIChoiceQuestionBody((answerFormat as RPChoiceAnswerFormat),
            (result) {
          currentQuestionBodyResult = result;
        });
      default:
        return Container();
    }
  }

  List<Widget> makeTextContent() {
    TextStyle textStyle = widget.step.identifier.contains('prick')
        ? ThemeTextStyle.regularIBM18sp
        : ThemeTextStyle.headline24sp;

    return widget.step.textContent
        .map((s) => Text(Languages.of(context)!.translate(s),
            style: textStyle, textAlign: TextAlign.center))
        .toList();
  }

  List<Widget> makeBottomSheetTextContent() {
    List<Widget> content = [];

    for (String s in widget.step.bottomSheetTextContent) {
      content.add(semiBoldText(
        Languages.of(context)!.translate(s),
        ThemeTextStyle.regularIBM20sp,
        TextAlign.justify,
      ));
      content.add(verticalSpacing(24));
    }
    content.removeLast();

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          children: [
            ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.35),
                child: Image.asset(widget.step.imagePath)),
            verticalSpacing(16),
            Text(
              Languages.of(context)!.translate(widget.step.title),
              style: ThemeTextStyle.headline24sp,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        // Text
        ...makeTextContent(),
        BottomSheetButton(
            icon: const Icon(
              Icons.help_outline_rounded,
              size: 20,
            ),
            label: Languages.of(context)!.translate('common.more-info'),
            bottomSheetTitle:
                Languages.of(context)!.translate(widget.step.bottomSheetTitle),
            content: Column(children: makeBottomSheetTextContent())),
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
