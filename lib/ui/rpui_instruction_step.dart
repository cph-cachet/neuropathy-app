import 'package:flutter/material.dart';
import 'package:neuro_planner/step/steps/rp_instruction_step.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';
import 'package:research_package/research_package.dart';

class RPUIInstructionStepWithChildren extends StatelessWidget {
  final RPInstructionStepWithChildren step;

  const RPUIInstructionStepWithChildren({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    blocQuestion.sendReadyToProceed(true);
    return Material(
      textStyle: ThemeTextStyle.headline24sp,
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(step.title, style: ThemeTextStyle.header1, textAlign: TextAlign.center),
            ...step.instructionContent
          ],
        ),
      ),
    );
  }
}
