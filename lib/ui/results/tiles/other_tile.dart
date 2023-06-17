import 'package:flutter/material.dart';
import 'package:neuro_planner/survey/motor_part.dart';
import 'package:neuro_planner/ui/results/tiles/vibration_tile.dart';

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
    final general = taskResult.results[symptomsStep.identifier] as RPStepResult;
    final Map<String, int> motorScores = Map.fromEntries(taskResult
        .results.entries
        .where((element) => MotorStrings.values
            .map((e) => e.identifier)
            .toList()
            .contains(element.key))
        .map((e) => MapEntry(e.key, e.value as RPStepResult))
        .map((e) =>
            MapEntry(e.key, e.value.results['answer'][0]['value'] as int)));

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
              motorScores.values
                  .fold(general.results['answer'][0]['value'],
                      (previousValue, element) => previousValue + element)
                  .toString(),
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
                StackedResultRow(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    items: [
                      horizontalSpacing(24),
                      StackedResultItem(
                        translationSection: 'vibration',
                        skipMiddleLabel: true,
                        label: MotorStrings.rightGreatToe.identifier,
                        score:
                            motorScores[MotorStrings.rightGreatToe.identifier]!,
                      ),
                    ],
                    leading: StackedLeadingItem(
                        isLeftOverride: false,
                        sectionIdentifier:
                            MotorStrings.rightGreatToe.identifier)),
                StackedResultRow(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    items: [
                      horizontalSpacing(24),
                      StackedResultItem(
                        translationSection: 'vibration',
                        skipMiddleLabel: true,
                        label: MotorStrings.leftGreatToe.identifier,
                        score:
                            motorScores[MotorStrings.leftGreatToe.identifier]!,
                      )
                    ],
                    leading: StackedLeadingItem(
                        isLeftOverride: true,
                        sectionIdentifier:
                            MotorStrings.leftGreatToe.identifier)),
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
                  score: general.results['answer'][0]['value']!,
                  skipMiddleLabel: true,
                  scoreZeroLabel: 'common.no',
                  scoreOverZeroLabel: 'common.yes',
                ),
                horizontalSpacing(24),
                if (general.results['answer'][0]['value']! > 0)
                  Text(
                    Languages.of(context)!
                        .translate(general.results['answer'][0]['text']),
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
