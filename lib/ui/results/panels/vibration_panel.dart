import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:neuro_planner/survey/vibration_part.dart';
import 'package:neuro_planner/utils/spacing.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';
import 'package:vibration/vibration.dart';

import '../../../languages.dart';

class VibrationPanelBody extends StatelessWidget {
  VibrationPanelBody({Key? key, required this.vibrationScores})
      : super(key: key);

  final Map<String, int> vibrationScores;
  late Map<String, int> leftScores = Map.fromEntries(vibrationScores.entries
      .where((element) =>
          leftVibrationSteps.contains(element.key) &&
          element.key != VibrationStrings.leftToeExtension.identifier));
  late Map<String, int> rightScores = Map.fromEntries(vibrationScores.entries
      .where((element) =>
          rightVibrationSteps.contains(element.key) &&
          element.key != VibrationStrings.rightToeExtension.identifier));

  @override
  Widget build(BuildContext context) {
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
          VibrationResultRow(
            leading:
                VibrationLeadingItem(sectionIdentifier: leftScores.keys.first),
            items: leftScores.entries
                .map((e) => VibrationResultItem(
                      label: e.key,
                      score: e.value,
                    ))
                .toList(),
          ),
          verticalSpacing(8),
          VibrationResultRow(
            leading:
                VibrationLeadingItem(sectionIdentifier: rightScores.keys.first),
            items: rightScores.entries
                .map((e) => VibrationResultItem(
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
              VibrationResultRow(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  items: [
                    horizontalSpacing(24),
                    VibrationResultItem(
                      skipMiddleLabel: true,
                      label: VibrationStrings.rightToeExtension.identifier,
                      score: vibrationScores[
                          VibrationStrings.rightToeExtension.identifier]!,
                    ),
                  ],
                  leading: VibrationLeadingItem(
                      sectionIdentifier:
                          VibrationStrings.rightToeExtension.identifier)),
              VibrationResultRow(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  items: [
                    horizontalSpacing(24),
                    VibrationResultItem(
                      skipMiddleLabel: true,
                      label: VibrationStrings.leftToeExtension.identifier,
                      score: vibrationScores[
                          VibrationStrings.leftToeExtension.identifier]!,
                    )
                  ],
                  leading: VibrationLeadingItem(
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

class VibrationResultItem extends StatelessWidget {
  final String label;
  final int score;
  final bool skipMiddleLabel;
  final String? scoreOverZeroLabel;
  final String? scoreZeroLabel;

  const VibrationResultItem({
    super.key,
    required this.label,
    required this.score,
    this.skipMiddleLabel = false,
    this.scoreOverZeroLabel,
    this.scoreZeroLabel,
  });

  @override
  Widget build(BuildContext context) {
    String translateString = score > 0
        ? scoreOverZeroLabel ?? 'common.no'
        : scoreZeroLabel ?? 'common.yes';
    String translateLabel = StringUtils.removeExp(label, '.+_');
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          Languages.of(context)!.translate(translateString),
          style: ThemeTextStyle.regularIBM18sp.copyWith(
              color: score > 0
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.secondary),
        ),
        if (!skipMiddleLabel)
          Text(
              Languages.of(context)!
                  .translate('results.vibration.$translateLabel'),
              style: ThemeTextStyle.resultsLabelsStyle),
        if (score > 0)
          Text(
            '+$score',
            style: ThemeTextStyle.regularIBM14sp
                .copyWith(color: Theme.of(context).colorScheme.error),
          )
      ],
    );
  }
}

class VibrationLeadingItem extends StatelessWidget {
  final String sectionIdentifier;

  const VibrationLeadingItem({super.key, required this.sectionIdentifier});

  @override
  Widget build(BuildContext context) {
    bool isLeft = leftVibrationSteps.contains(sectionIdentifier);
    return Column(
      children: [
        isLeft
            ? Icon(Icons.thumb_up_sharp)
            : Transform.flip(flipX: true, child: Icon(Icons.thumb_up_sharp)),
        Text(
          Languages.of(context)!.translate(
              isLeft ? 'results.vibration.left' : 'results.vibration.right'),
          style: ThemeTextStyle.resultsSmallLabelStyle,
        ),
      ],
    );
  }
}

class VibrationResultRow extends StatelessWidget {
  final List<Widget> items;
  final Widget leading;
  final CrossAxisAlignment crossAxisAlignment;

  const VibrationResultRow(
      {super.key,
      required this.items,
      required this.leading,
      this.crossAxisAlignment = CrossAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        leading,
        ...items,
      ],
    );
  }
}
