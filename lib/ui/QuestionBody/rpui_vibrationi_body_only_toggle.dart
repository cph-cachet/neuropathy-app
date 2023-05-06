import 'package:flutter/material.dart';
import 'package:neuro_planner/step/steps/rp_vibration_step.dart';
import 'package:neuro_planner/utils/spacing.dart';
import 'package:neuro_planner/utils/themes/styles.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';

class RPUIVibrationBodyOnlyToggle extends StatelessWidget {
  final RPVibrationStep vibrationStep;
  final Widget toggleButton;

  const RPUIVibrationBodyOnlyToggle(
      {super.key, required this.vibrationStep, required this.toggleButton});

  @override
  Widget build(BuildContext context) {
    return Material(
      textStyle: ThemeTextStyle.headline24sp,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(vibrationStep.title),
              const Text('Put the phone aside.'),
              Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(text: 'Grab your ', children: <TextSpan>[
                    TextSpan(
                        text: vibrationStep.text,
                        style: ThemeTextStyle.headline24sp
                            .copyWith(fontWeight: FontWeight.bold)),
                    const TextSpan(
                        text:
                            ' great toe with your fingers and move it in all directions a couple of times.'),
                  ])),
              Column(
                children: [
                  const Text('Can you feel the movement in the joints?',
                      textAlign: TextAlign.center),
                  verticalSpacing(8),
                  TextButton.icon(
                      onPressed: (() {}),
                      icon: const Icon(
                        Icons.help_outline_rounded,
                        size: 20,
                      ),
                      label: const Text('More Information')),
                ],
              ),
              toggleButton,
            ],
          ),
        ),
      ),
    );
  }
}
