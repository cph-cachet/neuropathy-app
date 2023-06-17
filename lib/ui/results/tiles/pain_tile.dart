import 'package:flutter/material.dart';
import 'package:neuro_planner/languages.dart';
import 'package:neuro_planner/step/steps/rp_pain_slider_question_step.dart';
import 'package:neuro_planner/survey/step_identifiers.dart';
import 'package:neuro_planner/ui/results/tiles/vibration_tile.dart';
import 'package:neuro_planner/utils/spacing.dart';
import 'package:research_package/model.dart';

import '../../../survey/pain_questionaire_part.dart';
import '../../../utils/themes/text_styles.dart';
import '../../widgets/neuropathy_icons.dart';

class PainTile extends StatelessWidget {
  final RPTaskResult taskResult;

  const PainTile({super.key, required this.taskResult});

  @override
  Widget build(BuildContext context) {
    Map<String, RPStepResult> painResults = Map.fromEntries(taskResult
            .results.entries
            .where((element) => painStepIdentifiers.contains(element.key)))
        .cast<String, RPStepResult>();

    int painScore = painResults.values
        .where((element) => element.identifier != painSlider.identifier)
        .fold(
            0,
            (previousValue, element) =>
                previousValue +
                (element.results['answer'].fold(0, (p, e2) => p + e2['value'])
                    as int));
    List<int> stackedRowScores = [
      painResults[pain3.identifier]
              ?.results['answer']
              ?.map(((e) => e['text']))
              .toList()
              .contains(pain3ChoicesStrings[0])
          ? 1
          : 0,
      painResults[pain3.identifier]
              ?.results['answer']
              ?.map(((e) => e['text']))
              .toList()
              .contains(pain3ChoicesStrings[1])
          ? 1
          : 0,
      painResults[pain4.identifier]?.results['answer'][0]['value'],
    ];

    return ExpansionTile(
      title: Text(
        Languages.of(context)!.translate('results.pain.title'),
        style: ThemeTextStyle.regularIBM20sp,
      ),
      leading: Icon(
        NeuropathyIcons.bi_bandaid_fill,
        size: 40,
        color: Theme.of(context).colorScheme.primary,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32),
          child: Column(
            children: [
              Text(
                Languages.of(context)!.translate('results.pain.score'),
                style: ThemeTextStyle.resultsLabelsStyle,
              ),
              Text(
                painScore.toString(),
                style: ThemeTextStyle.headline24sp,
              ),
              verticalSpacing(24),
              Text(Languages.of(context)!.translate('results.pain.sensitivity'),
                  style: ThemeTextStyle.resultsLabelsStyle),
              verticalSpacing(8),
              _PainStackedRow(scores: stackedRowScores),
              verticalSpacing(16),
              Text(Languages.of(context)!.translate('results.pain.level'),
                  style: ThemeTextStyle.resultsLabelsStyle),
              AbsorbPointer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text('0', style: ThemeTextStyle.regularIBM16sp),
                      Expanded(
                        child: Slider(
                          activeColor:
                              Theme.of(context).sliderTheme.activeTrackColor,
                          inactiveColor:
                              Theme.of(context).sliderTheme.inactiveTrackColor,
                          value: painResults[painSlider.identifier]
                                  ?.results['answer'] ??
                              0,
                          onChanged: (_) {},
                          min: 0,
                          max: 100,
                          divisions: 100,
                        ),
                      ),
                      Text('100', style: ThemeTextStyle.regularIBM16sp)
                    ],
                  ),
                ),
              ),
              verticalSpacing(16),
              Text(
                  Languages.of(context)!
                      .translate('results.pain.characteristics'),
                  style: ThemeTextStyle.resultsLabelsStyle),
              verticalSpacing(8),
              _ResultItemRow(
                iconData: NeuropathyIcons.fire,
                label: Languages.of(context)!.translate('results.pain.burning'),
              ),
              verticalSpacing(24),
              Text(Languages.of(context)!.translate('results.pain.other'),
                  style: ThemeTextStyle.resultsLabelsStyle),
              verticalSpacing(8),
              _ResultItemRow(
                iconData: NeuropathyIcons.itching,
                label: Languages.of(context)!.translate('results.pain.burning'),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _PainStackedRow extends StatelessWidget {
  final List<int> scores;

  const _PainStackedRow({required this.scores});

  @override
  Widget build(BuildContext context) {
    return const StackedResultRow(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        items: [
          StackedResultItem(
            scoreOverZeroLabel: 'results.pain.decreased',
            scoreZeroLabel: 'results.pain.normal',
            translationSection: 'pain',
            label: 'touch',
            score: 0,
          ),
          StackedResultItem(
            scoreOverZeroLabel: 'results.pain.decreased',
            scoreZeroLabel: 'results.pain.normal',
            translationSection: 'pain',
            label: 'prick',
            score: 1,
          ),
          StackedResultItem(
            scoreOverZeroLabel: 'results.pain.increased',
            scoreZeroLabel: 'results.pain.normal',
            translationSection: 'pain',
            label: 'stroking',
            score: 0,
          ),
        ]);
  }
}

class _ResultItemRow extends StatelessWidget {
  final IconData iconData;
  final String label;

  const _ResultItemRow({required this.iconData, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          iconData,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
        horizontalSpacing(4),
        Text(
          label,
          style: ThemeTextStyle.resultSectionLabelStyle,
        ),
        horizontalSpacing(4),
        Text(
          '+1',
          style: ThemeTextStyle.regularIBM14sp
              .copyWith(color: Theme.of(context).colorScheme.error),
        )
      ],
    );
  }
}
