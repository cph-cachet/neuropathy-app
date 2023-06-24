// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:research_package/model.dart';

import 'package:neuropathy_grading_tool/survey/vibration_part.dart';
import 'package:neuropathy_grading_tool/ui/widgets/neuropathy_icons.dart';
import 'package:neuropathy_grading_tool/utils/spacing.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';

import '../../../languages.dart';

class VibrationTile extends StatelessWidget {
  final RPTaskResult result;
  const VibrationTile({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, int> vibrationScores = Map.fromEntries(result.results.values
        .cast<RPStepResult>()
        .toList()
        .where(
            (element) => allVibrationIdentifiers.contains(element.identifier))
        .map((e) =>
            MapEntry(e.identifier, e.results['answer'][0]['value'] as int)));

    return ExpansionTile(
        title: Text(Languages.of(context)!.translate('results.vibration.title'),
            style: ThemeTextStyle.regularIBM20sp),
        leading: Icon(
          NeuropathyIcons.bxs_mobile_vibration,
          size: 40,
          color: Theme.of(context).colorScheme.primary,
        ),
        children: [
          VibrationTileBody(vibrationScores: vibrationScores),
        ]);
  }
}

class VibrationTileBody extends StatelessWidget {
  const VibrationTileBody({Key? key, required this.vibrationScores})
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
                      label:
                          'results.vibration.${StringUtils.removeExp(e.key, '.+_')}',
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
                      label:
                          'results.vibration.${StringUtils.removeExp(e.key, '.+_')}',
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
  final String? scoreOverZeroLabel;
  final String? scoreZeroLabel;
  final bool skipScoreCount;
  final Widget? overrideScoreResult;

  const StackedResultItem({
    super.key,
    this.label,
    required this.score,
    this.scoreOverZeroLabel,
    this.scoreZeroLabel,
    this.skipScoreCount = false,
    this.overrideScoreResult,
  });

  @override
  Widget build(BuildContext context) {
    String translateString = score > 0
        ? scoreOverZeroLabel ?? 'common.no'
        : scoreZeroLabel ?? 'common.yes';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (label != null)
          Text(Languages.of(context)!.translate(label!),
              style: ThemeTextStyle.resultsLabelsStyle),
        overrideScoreResult == null
            ? Text(
                Languages.of(context)!.translate(translateString),
                style: ThemeTextStyle.regularIBM18sp.copyWith(
                    color: score > 0
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.secondary),
              )
            : overrideScoreResult!,
        if (score > 0 && !skipScoreCount)
          Text(
            '+$score',
            style: ThemeTextStyle.regularIBM14sp
                .copyWith(color: Theme.of(context).colorScheme.error),
          ),
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
