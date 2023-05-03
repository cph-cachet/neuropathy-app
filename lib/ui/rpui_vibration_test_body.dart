import 'package:flutter/material.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                //width: MediaQuery.of(context).size.width * 0.5,
                child: Image.asset(
                    widget.vibrationStep.vibrationSection.imagePath)),
            Text(
              widget.vibrationStep.title,
            ),
            Text(
              widget.vibrationStep.text ?? '',
            ),
            ElevatedButton(
              onPressed: () {
                print(widget.vibrationStep.vibrationSection.imagePath);
                //Vibration.vibrate(duration: 30000);
              },
              child: Text('Start vibration'),
            ),
            const Text('Can you feel the vibration?'),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: RPUIChoiceQuestionBody(
                    (widget.vibrationStep.answerFormat as RPChoiceAnswerFormat),
                    (result) {
                  currentQuestionBodyResult = result;
                })
                // todo toggle buttons, move to separate widget component
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
    );
  }

  @override // TODO: implement
  void createAndSendResult() {
    result.questionTitle = widget.vibrationStep.title;
    result.setResult(_currentQuestionBodyResult);
    blocTask.sendStepResult(result);
  }
}
