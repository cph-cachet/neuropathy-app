import 'package:flutter/material.dart';
import 'package:neuro_planner/ui/widgets/toggle_button.dart';
import 'package:neuro_planner/ui/widgets/vibration_button.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';
import 'package:research_package/research_package.dart';
import '../step/steps/rp_vibration_step.dart';
import '../utils/spacing.dart';

// TODO: Decide if vertical padding is more useful than alignment
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
    super.initState();
    result = RPStepResult(
        identifier: widget.vibrationStep.identifier,
        questionTitle: widget.vibrationStep.title,
        answerFormat: widget.vibrationStep.answerFormat);
    blocQuestion.sendReadyToProceed(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.35),
                  child: Image.asset(
                      widget.vibrationStep.vibrationSection.imagePath,
                      fit: BoxFit.cover),
                ),
                Text(widget.vibrationStep.title,
                    style: ThemeTextStyle.headline24sp),
              ],
            ),
            //verticalSpacing(8),
            //verticalSpacing(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                widget.vibrationStep.text ?? '',
                style: ThemeTextStyle.regularIBM18sp,
                textAlign: TextAlign.center,
              ),
            ),
            //verticalSpacing(24),
            const VibrationButton(),
            //verticalSpacing(24),
            Text(
              'Can you feel the vibration?',
              style: ThemeTextStyle.regularIBM18sp,
              textAlign: TextAlign.center,
            ), // TODO: change to processing locale
            //verticalSpacing(24),
            ToggleButton(
                answerFormat:
                    widget.vibrationStep.answerFormat as RPChoiceAnswerFormat,
                onPressed: (result) {
                  currentQuestionBodyResult = result;
                }),
            verticalSpacing(8)
          ],
        ),
      ),
    );
  }

  @override
  void createAndSendResult() {
    result.questionTitle = widget.vibrationStep.title;
    result.setResult(_currentQuestionBodyResult);
    blocTask.sendStepResult(result);
  }
}
