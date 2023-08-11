import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/examination/steps/rp_instruction_step.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';
import 'package:research_package/research_package.dart';

import 'package:neuropathy_grading_tool/languages.dart';

class RPUIInstructionStepWithChildren extends StatelessWidget {
  final RPInstructionStepWithChildren step;

  const RPUIInstructionStepWithChildren({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    blocQuestion.sendReadyToProceed(true);

    List<Text> children = step.textContent
        .map((s) => Text(Languages.of(context)!.translate(s),
            textAlign: TextAlign.center))
        .toList();

    return Material(
      textStyle: AppTextStyle.headline24sp,
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(Languages.of(context)!.translate(step.title),
                style: AppTextStyle.header1, textAlign: TextAlign.center),
            ...children
          ],
        ),
      ),
    );
  }
}
