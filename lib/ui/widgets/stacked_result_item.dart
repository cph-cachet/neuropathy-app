import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/ui/widgets/neuropathy_icons.dart';
import 'package:neuropathy_grading_tool/utils/spacing.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';

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
  final bool isLeft;

  const StackedLeadingItem({super.key, required this.isLeft});

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
        leading: StackedLeadingItem(
          isLeft: isLeft,
        ));
  }
}
