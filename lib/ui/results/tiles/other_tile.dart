import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/survey/motor_part.dart';
import 'package:neuropathy_grading_tool/ui/widgets/stacked_result_item.dart';

import 'package:research_package/model.dart';

import '../../../languages.dart';
import '../../../survey/symptoms_part.dart';
import '../../../utils/spacing.dart';
import '../../../utils/themes/text_styles.dart';

class OtherFindingsTile extends StatelessWidget {
  final RPTaskResult taskResult;

  const OtherFindingsTile({super.key, required this.taskResult});

  @override
  Widget build(BuildContext context) {
    final symptoms =
        taskResult.results[symptomsStep.identifier] as RPStepResult;
    final Map<String, int> motorScores = Map.fromEntries(taskResult
        .results.entries
        .where((element) => MotorStrings.values
            .map((e) => e.identifier)
            .toList()
            .contains(element.key))
        .map((e) => MapEntry(e.key, e.value as RPStepResult))
        .map((e) =>
            MapEntry(e.key, e.value.results['answer'][0]['value'] as int)));
    // otherScore is symptom score plus both motor scores
    final otherScore = motorScores.values.fold(
        symptoms.results['answer'][0]['value'],
        (previousValue, element) => previousValue + element);

    return ExpansionTile(
      title: Text(
        Languages.of(context)!.translate('results.other.title'),
        style: ThemeTextStyle.regularIBM20sp,
      ),
      leading: Icon(
        Icons.thermostat_outlined,
        size: 40,
        color: Theme.of(context).colorScheme.primary,
      ),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Languages.of(context)!
                  .translate('results.vibration.section-score'),
              style: ThemeTextStyle.resultsLabelsStyle,
            ),
            Text(
              otherScore.toString(),
              style: ThemeTextStyle.headline24sp,
            ),
            verticalSpacing(16),
            Text(Languages.of(context)!.translate('results.other.motor'),
                style: ThemeTextStyle.resultSectionLabelStyle),
            verticalSpacing(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OneItemWLeadingResRow(
                    score: motorScores[MotorStrings.rightGreatToe.identifier]!,
                    isLeft: false),
                OneItemWLeadingResRow(
                    score: motorScores[MotorStrings.leftGreatToe.identifier]!,
                    isLeft: true),
              ],
            ),
            verticalSpacing(24),
            Text(Languages.of(context)!.translate('results.other.symptoms'),
                style: ThemeTextStyle.resultSectionLabelStyle),
            verticalSpacing(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StackedResultItem(
                  score: symptoms.results['answer'][0]['value']!,
                  scoreZeroLabel: 'common.no',
                  scoreOverZeroLabel: 'common.yes',
                ),
                horizontalSpacing(24),
                if (symptoms.results['answer'][0]['value']! > 0)
                  Text(
                    Languages.of(context)!
                        .translate(symptoms.results['answer'][0]['text']),
                    style: ThemeTextStyle.resultsLabelsStyle,
                  )
              ],
            ),
          ],
        )
      ],
    );
  }
}
