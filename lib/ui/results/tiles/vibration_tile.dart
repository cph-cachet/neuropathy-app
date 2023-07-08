import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:research_package/model.dart';

import 'package:neuropathy_grading_tool/examination/sections/vibration_part.dart';
import 'package:neuropathy_grading_tool/utils/neuropathy_icons.dart';
import 'package:neuropathy_grading_tool/ui/widgets/stacked_result_item.dart';
import 'package:neuropathy_grading_tool/ui/widgets/spacing.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';

/// An [ExpansionTile] widget that displays the vibration part of the examination results.
///
/// The section score is the sum of the scores of the vibration questions.
/// All of the results in this section are presented with either a [_VibrationLegResultRow] which uses
/// [StackedResultRow] or [OneItemWLeadingResRow].
class VibrationTile extends StatelessWidget {
  final RPTaskResult result;
  const VibrationTile({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Map of the results of the vibration questions. The key is the identifier of the question.
    /// The value is the score of the question.
    Map<String, int> vibrationScores = Map.fromEntries(result.results.values
        .cast<RPStepResult>()
        .toList()
        .where(
            (element) => allVibrationIdentifiers.contains(element.identifier))
        .map((e) =>
            MapEntry(e.identifier, e.results['answer'][0]['value'] as int)));

    return ExpansionTile(
        title: Text(Languages.of(context)!.translate('results.vibration.title'),
            style: AppTextStyle.regularIBM20sp),
        leading: Icon(
          NeuropathyIcons.bxs_mobile_vibration,
          size: 40,
          color: Theme.of(context).colorScheme.primary,
        ),
        children: [
          _VibrationTileBody(vibrationScores: vibrationScores),
        ]);
  }
}

/// The body of the [VibrationTile].
class _VibrationTileBody extends StatelessWidget {
  const _VibrationTileBody({Key? key, required this.vibrationScores})
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
            style: AppTextStyle.resultsLabelsStyle,
          ),
          Text(
            vibrationScores.values
                .fold(0, (previousValue, element) => previousValue + element)
                .toString(),
            style: AppTextStyle.headline24sp,
          ),
          verticalSpacing(16),
          Text(
              Languages.of(context)!
                  .translate('results.vibration.feeling-vibration'),
              style: AppTextStyle.resultSectionLabelStyle),
          verticalSpacing(8),
          _VibrationLegResultRow(items: leftScores, isLeft: true),
          verticalSpacing(8),
          _VibrationLegResultRow(items: rightScores, isLeft: false),
          verticalSpacing(8),
          Text(
              Languages.of(context)!.translate('results.vibration.feeling-toe'),
              style: AppTextStyle.resultSectionLabelStyle),
          verticalSpacing(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OneItemWLeadingResRow(
                  score: vibrationScores[
                      VibrationStrings.leftToeExtension.identifier]!,
                  isLeft: true),
              OneItemWLeadingResRow(
                  score: vibrationScores[
                      VibrationStrings.rightToeExtension.identifier]!,
                  isLeft: false),
            ],
          ),
          verticalSpacing(16)
        ],
      ),
    );
  }
}

/// A [StackedResultRow] widget that displays the results of the vibration questions.
///
/// The leading widget is a [ResultFootWithLabelItem], to which the [isLeft] parameter is passed.
///
/// The results are displayed with [StackedResultItem]s.
/// Since the key is the identifier of the question, we remove the prefix
/// which for vibration questions is ```vibration_leg_section```.
/// Then instead of 6 translation strings we only need 3.
/// For example: ```vibration_left_toe``` becomes ```results.vibration.toe```
class _VibrationLegResultRow extends StatelessWidget {
  final Map<String, int> items;
  final bool isLeft;
  const _VibrationLegResultRow({
    Key? key,
    required this.items,
    required this.isLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StackedResultRow(
      items: items.entries
          .map((e) => StackedResultItem(
                label:
                    'results.vibration.${StringUtils.removeExp(e.key, '.+_')}',
                score: e.value,
              ))
          .toList(),
      leading: ResultFootWithLabelItem(isLeft: isLeft),
    );
  }
}
