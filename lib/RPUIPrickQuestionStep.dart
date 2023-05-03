import 'RPPrickQuestionStep.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:research_package/research_package.dart';

class RPUIPrickQuestionStep extends StatefulWidget {
  final RPPrickQuestionStep step;

  const RPUIPrickQuestionStep(this.step, {super.key});

  @override
  RPUIPrickQuestionStepState createState() => RPUIPrickQuestionStepState();
}

class RPUIPrickQuestionStepState extends State<RPUIPrickQuestionStep>
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

  Image prickSectionImage(PrickSection prickSection) {
    switch (prickSection) {
      case PrickSection.Left1:
        return Image.asset('assets/LeftLeg1.png', scale: 0.9);
      case PrickSection.Left2:
        return Image.asset('assets/LeftLeg2.png', scale: 0.9);
      case PrickSection.Left3:
        return Image.asset('assets/LeftLeg3.png', scale: 0.9);
      case PrickSection.Left4:
        return Image.asset('assets/LeftLeg4.png', scale: 0.9);
      case PrickSection.Left5:
        return Image.asset('assets/LeftLeg5.png', scale: 0.9);
      case PrickSection.Left6:
        return Image.asset('assets/LeftLeg6.png', scale: 0.9);
      case PrickSection.Right1:
        return Image.asset('assets/RightLeg1.png', scale: 0.9);
      case PrickSection.Right2:
        return Image.asset('assets/RightLeg2.png', scale: 0.9);
      case PrickSection.Right3:
        return Image.asset('assets/RightLeg3.png', scale: 0.9);
      case PrickSection.Right4:
        return Image.asset('assets/RightLeg4.png', scale: 0.9);
      case PrickSection.Right5:
        return Image.asset('assets/RightLeg5.png', scale: 0.9);
      case PrickSection.Right6:
        return Image.asset('assets/RightLeg6.png', scale: 0.9);
      default:
        return Image.asset('DTUlogo.png');
    }
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
              prickSectionImage(widget.step.prickSection),
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

  @override // TODO: implement
  void createAndSendResult() {
    result.questionTitle = widget.step.title;
    result.setResult(_currentQuestionBodyResult);
    blocTask.sendStepResult(result);
  }
}
