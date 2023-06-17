import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:neuro_planner/survey/vibration_part.dart';
import 'package:neuro_planner/ui/widgets/neuropathy_icons.dart';
import 'package:neuro_planner/utils/spacing.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';

import '../../../languages.dart';

class VibrationPanelBody extends StatelessWidget {
  const VibrationPanelBody({Key? key, required this.vibrationScores})
      : super(key: key);

  final Map<String, int> vibrationScores;

  @override
  Widget build(BuildContext context) {
    Map<String, int> leftScores = Map.fromEntries(vibrationScores.entries.where(
        (element) =>
            leftVibrationSteps.contains(element.key) &&
            element.key != VibrationStrings.leftToeExtension.identifier));
    Map<String, int> rightScores = Map.fromEntries(vibrationScores.entries
        .where((element) =>
            rightVibrationSteps.contains(element.key) &&
            element.key != VibrationStrings.rightToeExtension.identifier));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            Languages.of(context)!.translate('results.vibration.section-score'),
            style: ThemeTextStyle.resultsLabelsStyle,
          ),
          Text(
            vibrationScores.values
                .fold(0, (previousValue, element) => previousValue + element)
                .toString(),
            style: ThemeTextStyle.headline24sp,
          ),
          verticalSpacing(16),
          Text(
              Languages.of(context)!
                  .translate('results.vibration.feeling-vibration'),
              style: ThemeTextStyle.resultSectionLabelStyle),
          verticalSpacing(8),
          StackedResultRow(
            leading:
                StackedLeadingItem(sectionIdentifier: leftScores.keys.first),
            items: leftScores.entries
                .map((e) => StackedResultItem(
                      translationSection: 'vibration',
                      label: e.key,
                      score: e.value,
                    ))
                .toList(),
          ),
          verticalSpacing(8),
          StackedResultRow(
            leading:
                StackedLeadingItem(sectionIdentifier: rightScores.keys.first),
            items: rightScores.entries
                .map((e) => StackedResultItem(
                      translationSection: 'vibration',
                      label: e.key,
                      score: e.value,
                    ))
                .toList(),
          ),
          verticalSpacing(8),
          Text(
              Languages.of(context)!.translate('results.vibration.feeling-toe'),
              style: ThemeTextStyle.resultSectionLabelStyle),
          verticalSpacing(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //TODO: move that to separate ez generated widget
              StackedResultRow(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  items: [
                    horizontalSpacing(24),
                    StackedResultItem(
                      translationSection: 'vibration',
                      skipMiddleLabel: true,
                      label: VibrationStrings.rightToeExtension.identifier,
                      score: vibrationScores[
                          VibrationStrings.rightToeExtension.identifier]!,
                    ),
                  ],
                  leading: StackedLeadingItem(
                      sectionIdentifier:
                          VibrationStrings.rightToeExtension.identifier)),
              StackedResultRow(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  items: [
                    horizontalSpacing(24),
                    StackedResultItem(
                      translationSection: 'vibration',
                      skipMiddleLabel: true,
                      label: VibrationStrings.leftToeExtension.identifier,
                      score: vibrationScores[
                          VibrationStrings.leftToeExtension.identifier]!,
                    )
                  ],
                  leading: StackedLeadingItem(
                      sectionIdentifier:
                          VibrationStrings.leftToeExtension.identifier))
            ],
          ),
          verticalSpacing(16)
        ],
      ),
    );
  }
}

class StackedResultItem extends StatelessWidget {
  final String? label;
  final int score;
  final bool skipMiddleLabel;
  final String? scoreOverZeroLabel;
  final String? scoreZeroLabel;
  final bool skipScoreCount;
  final String? translationSection;
  final Widget? overrideScoreResult;

  const StackedResultItem({
    super.key,
    this.label,
    required this.score,
    this.skipMiddleLabel = false,
    this.scoreOverZeroLabel,
    this.scoreZeroLabel,
    this.skipScoreCount = false,
    this.translationSection,
    this.overrideScoreResult,
  });

  @override
  Widget build(BuildContext context) {
    String translateString = score > 0
        ? scoreOverZeroLabel ?? 'common.no'
        : scoreZeroLabel ?? 'common.yes';
    String translateLabel = label != null
        ? translationSection == 'vibration'
            ? StringUtils.removeExp(label!, '.+_')
            : label!
        : '';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        overrideScoreResult == null
            ? Text(
                Languages.of(context)!.translate(translateString),
                style: ThemeTextStyle.regularIBM18sp.copyWith(
                    color: score > 0
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.secondary),
              )
            : overrideScoreResult!,
        if (!skipMiddleLabel)
          Text(
              Languages.of(context)!
                  .translate('results.$translationSection.$translateLabel'),
              style: ThemeTextStyle.resultsLabelsStyle),
        if (score > 0 && !skipScoreCount)
          Text(
            '+$score',
            style: ThemeTextStyle.regularIBM14sp
                .copyWith(color: Theme.of(context).colorScheme.error),
          )
      ],
    );
  }
}

class StackedLeadingItem extends StatelessWidget {
  final String sectionIdentifier;
  final bool? isLeftOverride;

  const StackedLeadingItem(
      {super.key, required this.sectionIdentifier, this.isLeftOverride});

  @override
  Widget build(BuildContext context) {
    bool isLeft =
        isLeftOverride ?? leftVibrationSteps.contains(sectionIdentifier);
    return Column(
      children: [
        isLeft
            ? const Icon(NeuropathyIcons.icon_park_foot, size: 30)
            : Transform.flip(
                flipX: true,
                child: const Icon(
                  NeuropathyIcons.icon_park_foot,
                  size: 30,
                )),
        Text(
          Languages.of(context)!.translate(
              isLeft ? 'results.vibration.left' : 'results.vibration.right'),
          style: ThemeTextStyle.resultsSmallLabelStyle,
        ),
      ],
    );
  }
}

class StackedResultRow extends StatelessWidget {
  final List<Widget> items;
  final Widget? leading;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const StackedResultRow(
      {super.key,
      required this.items,
      this.leading,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        if (leading != null) leading!,
        ...items,
      ],
    );
  }
}