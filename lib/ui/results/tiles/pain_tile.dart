import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/examination/sections/pain_questionaire_part.dart';
import 'package:neuropathy_grading_tool/examination/step_identifiers.dart';
import 'package:neuropathy_grading_tool/utils/neuropathy_icons.dart';
import 'package:neuropathy_grading_tool/ui/widgets/stacked_result_item.dart';
import 'package:neuropathy_grading_tool/ui/widgets/spacing.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';
import 'package:research_package/model.dart';

/// An [ExpansionTile] widget that displays the pain part of the examination results.
///
/// The section score is the sum of the scores of the pain questions, except the slider (pain level).
class PainTile extends StatelessWidget {
  final RPTaskResult taskResult;

  const PainTile({super.key, required this.taskResult});

  @override
  Widget build(BuildContext context) {
    /// Map of the results of the pain questions. The key is the identifier of the question.
    /// The value is the [RPStepResult] of the question.
    Map<String, RPStepResult> painResults = Map.fromEntries(taskResult
            .results.entries
            .where((element) => painStepIdentifiers.contains(element.key)))
        .cast<String, RPStepResult>();

    /// Total result of the pain section. It is the sum of the scores of the pain questions, except the slider (pain level).
    int painScore = painResults.values
        .where((element) => element.identifier != painSlider.identifier)
        .fold(
            0,
            (previousValue, element) =>
                previousValue +
                (element.results['answer'].fold(0, (p, e2) => p + e2['value'])
                    as int));

    /// Scores to display in the [_PainStackedRow].
    /// Since the ```pain3``` question is multiple choice, both option strings are checked in the selected choices.
    /// Otherwise it would be unclear what was selected if simply an answer value was used.
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
        style: AppTextStyle.regularIBM20sp,
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
                style: AppTextStyle.resultsLabelsStyle,
              ),
              Text(
                Languages.of(context)!.translate('results.pain.score-grading'),
                style: AppTextStyle.resultsLabelsStyle.copyWith(fontSize: 14),
              ),
              Text(
                painScore.toString(),
                style: AppTextStyle.headline24sp,
              ),
              verticalSpacing(24),
              Text(Languages.of(context)!.translate('results.pain.sensitivity'),
                  style: AppTextStyle.resultSectionLabelStyle),
              verticalSpacing(8),
              _PainStackedRow(scores: stackedRowScores),
              verticalSpacing(16),
              Text(Languages.of(context)!.translate('results.pain.level'),
                  style: AppTextStyle.resultSectionLabelStyle),
              AbsorbPointer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text('0', style: AppTextStyle.regularIBM16sp),
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
                      Text('100', style: AppTextStyle.regularIBM16sp)
                    ],
                  ),
                ),
              ),
              if (painResults[pain1.identifier]?.results['answer'][0]['text'] !=
                  'common.none-of-the-above')
                _PainMultipleChoiceResultWidget(
                  result: painResults[pain1.identifier]!,
                  icons: pain1Icons,
                  title: 'results.pain.characteristics',
                ),
              if (painResults[pain2.identifier]?.results['answer'][0]['text'] !=
                  'common.none-of-the-above')
                _PainMultipleChoiceResultWidget(
                  result: painResults[pain2.identifier]!,
                  icons: pain2Icons,
                  title: 'results.pain.other',
                ),
            ],
          ),
        )
      ],
    );
  }
}

/// A [StackedResultRow] widget for the pain sensitivity part of the examination results.
class _PainStackedRow extends StatelessWidget {
  final List<int> scores;

  const _PainStackedRow({required this.scores});

  @override
  Widget build(BuildContext context) {
    return StackedResultRow(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        items: [
          StackedResultItem(
            scoreOverZeroLabel: 'results.pain.decreased',
            scoreZeroLabel: 'results.pain.normal',
            label: 'results.pain.touch',
            score: scores[0],
          ),
          StackedResultItem(
            scoreOverZeroLabel: 'results.pain.decreased',
            scoreZeroLabel: 'results.pain.normal',
            label: 'results.pain.prick',
            score: scores[1],
          ),
          StackedResultItem(
            scoreOverZeroLabel: 'results.pain.increased',
            scoreZeroLabel: 'results.pain.normal',
            label: 'results.pain.stroking',
            score: scores[2],
          ),
        ]);
  }
}

/// A widget to present the results of multiple choice pain questions.
///
/// It displays all selected choices in a column with corresponding [icons].
/// The icons are retrieved based on identifiers in the [result].
class _PainMultipleChoiceResultWidget extends StatelessWidget {
  final RPStepResult result;
  final Map<String, IconData> icons;
  final String title;

  const _PainMultipleChoiceResultWidget(
      {required this.result, required this.icons, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpacing(24),
        Text(Languages.of(context)!.translate(title),
            style: AppTextStyle.resultSectionLabelStyle),
        verticalSpacing(8),
        ...result.results['answer'].map((e) => _PainChoiceItemRow(
            iconData: icons[e['text']] ?? Icons.error, label: e['text']))
      ],
    );
  }
}

/// A widget to display a single choice selected in a pain multiple choice question.
///
/// It displays the [iconData] and [label] of the choice, and a ```+1``` sign
/// as all choices contribute 1 to the pain score.
class _PainChoiceItemRow extends StatelessWidget {
  final IconData iconData;
  final String label;

  const _PainChoiceItemRow({required this.iconData, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: Theme.of(context).colorScheme.primary,
            size: 25,
          ),
          horizontalSpacing(4),
          Text(
            Languages.of(context)!.translate(label),
            style: AppTextStyle.resultsLabelsStyle,
          ),
          horizontalSpacing(4),
          Text(
            '+1',
            style: AppTextStyle.regularIBM14sp
                .copyWith(color: Theme.of(context).colorScheme.error),
          )
        ],
      ),
    );
  }
}
