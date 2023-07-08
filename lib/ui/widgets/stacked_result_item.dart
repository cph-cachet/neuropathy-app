import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/utils/neuropathy_icons.dart';
import 'package:neuropathy_grading_tool/utils/spacing.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';

/// A widget that displays a single result from examination, i.e left toe vibration score.
/// In default form it displays the [score] if above zero, and the [label] and a score label - localized Yes (score over zero) or No.
///
/// The [scoreOverZeroLabel] and [scoreZeroLabel] can be used to override the default score labels.
/// The [skipScoreCount] can be used to skip displaying the score count, i.e. when displaying the score for the whole foot,
/// and the score is passed as a [overrideScoreResult].
///
/// The [StackedResultItem] returns its children in a column, usually part of the [StackedResultRow].
/// The order of the children is: [label] (if present), Yes/No or [overrideScoreResult], [score].
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

/// A widget displaying a foot icon with label left/rigt (localized).
///
/// The [isLeft] parameter is used to determine the side of the foot and transform the icon accordingly.
class ResultFootWithLabelItem extends StatelessWidget {
  final bool isLeft;

  const ResultFootWithLabelItem({super.key, required this.isLeft});

  @override
  Widget build(BuildContext context) {
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
          Languages.of(context)!
              .translate(isLeft ? 'common.left' : 'common.right'),
          style: ThemeTextStyle.resultsSmallLabelStyle,
        ),
      ],
    );
  }
}

/// A row widget that displays a list of result [items] with a [leading] widget.
/// The [mainAxisAlignment] and [crossAxisAlignment] can be used to customize the layout.
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

/// A result Widget for Motor and Toe Extension parts,
/// producing a [StackedResultRow] with a [ResultFootWithLabelItem] and [StackedResultItem],
/// based only on [score] and [isLeft] parameters.
class OneItemWLeadingResRow extends StatelessWidget {
  final int score;
  final bool isLeft;
  const OneItemWLeadingResRow({
    Key? key,
    required this.score,
    required this.isLeft,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StackedResultRow(
        crossAxisAlignment: CrossAxisAlignment.center,
        items: [
          horizontalSpacing(24),
          StackedResultItem(
            score: score,
          ),
        ],
        leading: ResultFootWithLabelItem(
          isLeft: isLeft,
        ));
  }
}
