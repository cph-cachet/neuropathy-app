import 'package:flutter/material.dart';
import 'package:neuro_planner/utils/spacing.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';
import 'package:research_package/model.dart';
import 'package:research_package/research_package.dart';

import '../step/steps/rp_vibration_step.dart';

class RPUIVibrationStep extends StatefulWidget {
  final RPVibrationStep vibrationStep;

  RPUIVibrationStep(this.vibrationStep);

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
    // Instantiating the result object here to start the time counter (startDate)
    super.initState();

    result = RPStepResult(
        identifier: widget.vibrationStep.identifier,
        questionTitle: widget.vibrationStep.title,
        answerFormat: widget.vibrationStep.answerFormat);
    blocQuestion.sendReadyToProceed(false);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.vibrationStep.answerFormat);
    // List<Widget> answers =
    //     (widget.vibrationStep.answerFormat as RPChoiceAnswerFormat)
    //         .choices
    //         .map((choice) => Text(choice.text))
    //         .toList();
    return Scaffold(
      body: Center(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Image.asset(
                    widget.vibrationStep.vibrationSection.imagePath,
                    fit: BoxFit.cover),
              ),
              verticalSpacing(8),
              Text(widget.vibrationStep.title,
                  style: ThemeTextStyle.headline24sp),
              verticalSpacing(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.vibrationStep.text ?? '',
                  style: ThemeTextStyle.regularIBM18sp,
                  textAlign: TextAlign.center,
                ),
              ),
              verticalSpacing(24),
              ElevatedButton(
                onPressed: () {
                  //Vibration.vibrate(duration: 30000);
                },
                child: const Text('Start vibration'),
              ),
              verticalSpacing(24),
              Text(
                'Can you feel the vibration?',
                style: ThemeTextStyle.regularIBM18sp,
                textAlign: TextAlign.center,
              ), // TODO change to processing locale
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RPUIChoiceQuestionBody(
                      (widget.vibrationStep.answerFormat
                          as RPChoiceAnswerFormat), (result) {
                    currentQuestionBodyResult = result;
                  })
                  // TODO toggle buttons, move to separate widget component
                  //   child: ToggleButtons(
                  //     direction: Axis.horizontal,
                  //     onPressed: (index) {},
                  //     children: answers,
                  //     isSelected: List.generate(answers.length, (index) => false),
                  //   ),
                  )
            ],
          ),
        ),
      ),
    );
  }

  @override // TODO: implement
  void createAndSendResult() {
    result.questionTitle = widget.vibrationStep.title;
    result.setResult(_currentQuestionBodyResult);
    blocTask.sendStepResult(result);
  }
}
