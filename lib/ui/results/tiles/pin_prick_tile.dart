import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/examination/sections/prick_part.dart';

import 'package:neuropathy_grading_tool/utils/neuropathy_icons.dart';
import 'package:neuropathy_grading_tool/ui/widgets/stacked_result_item.dart';
import 'package:neuropathy_grading_tool/ui/widgets/spacing.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';
import 'package:research_package/research_package.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// An [ExpansionTile] to display pin-prick result part of the examination.
///
/// It displays the section score, which is the combined results from all pin-prick questions.
/// Then in displays two pages to switch between by swiping or clicking the Switch leg toggle.
/// The results for each leg are presented on the leg image, with sensitivity scores below.
/// Score for each leg is also provided.
class PinPrickTile extends StatefulWidget {
  const PinPrickTile({super.key, required this.result});
  final RPTaskResult result;

  @override
  State<PinPrickTile> createState() => _PinPrickTileState();
}

class _PinPrickTileState extends State<PinPrickTile> {
  /// [PageController] for changing the displayed leg
  final _controller = PageController();

  /// List of leg results, contains two elements, one for each leg
  late List<Map<String, int>> _legsResults;

  /// boolean to control the [AnimatedToggleSwitch]
  bool _isLeftSelected = true;

  /// Map the pin-prick results. The key is the identifier, and the value is
  /// the result of the question as [int].
  Map<String, int> _getResults(RPTaskResult result) {
    return Map.fromEntries(result.results.values
        .cast<RPStepResult>()
        .toList()
        .where((element) => pinPrickIdentifiers.contains(element.identifier))
        .map((e) =>
            MapEntry(e.identifier, e.results['answer'][0]['value'] as int)));
  }

  /// filters the results for left or right leg
  Map<String, int> _getResultsForLeg(RPTaskResult result, String leg) {
    Map<String, int> pinprickScores = _getResults(result);
    return Map.fromEntries(
        pinprickScores.entries.where((element) => element.key.contains(leg)));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _legsResults = [
        _getResultsForLeg(widget.result, 'left'),
        _getResultsForLeg(widget.result, 'right'),
      ];
    });
  }

  /// Animates the [PageView] to the selected page.
  /// Also updates the [_isLeftSelected] to reflect the change.
  void _onSelected(int index) {
    _controller.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    setState(() {
      _isLeftSelected = index == PinPrickLeg.left.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        Languages.of(context)!.translate('results.prick.title'),
        style: AppTextStyle.regularIBM20sp,
      ),
      leading: Icon(NeuropathyIcons.ph_needle_fillprick_needle,
          size: 40, color: Theme.of(context).colorScheme.primary),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Languages.of(context)!
                  .translate('results.vibration.section-score'),
              style: AppTextStyle.resultsLabelsStyle,
            ),
            Text(
              _getResults(widget.result)
                  .values
                  .fold(0, (previousValue, element) => previousValue + element)
                  .toString(),
              style: AppTextStyle.headline24sp,
            ),
            verticalSpacing(16),
            AnimatedToggleSwitch.dual(
                iconBuilder: (value) => value
                    ? Icon(
                        Icons.arrow_forward_rounded,
                        color: Theme.of(context).colorScheme.onPrimary,
                      )
                    : Icon(
                        Icons.arrow_back_rounded,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                indicatorSize: const Size(36, 36),
                height: 38,
                dif: 70,
                current: _isLeftSelected,
                first: true,
                second: false,
                borderWidth: 1,
                onChanged: (_) => _onSelected(_isLeftSelected
                    ? PinPrickLeg.right.index
                    : PinPrickLeg.left.index),
                borderColor: Theme.of(context).colorScheme.primary,
                colorBuilder: (_) => Theme.of(context).colorScheme.primary,
                textBuilder: (_) => Center(
                      child: Text(
                          Languages.of(context)!
                              .translate('results.prick.switch-leg')
                              .toUpperCase(),
                          style: AppTextStyle.extraLightIBM16sp.copyWith(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold)),
                    )),
            verticalSpacing(24),

            /// Page View to display the legs and switch between them
            SizedBox(
              height: 345,
              width: MediaQuery.of(context).size.width * 0.9,
              child: PageView(
                onPageChanged: (index) => _onSelected(index),
                controller: _controller,
                children: [
                  _PinPrickResultBody(
                      leg: PinPrickLeg.left, results: _legsResults[0]),
                  _PinPrickResultBody(
                      leg: PinPrickLeg.right, results: _legsResults[1])
                ],
              ),
            ),
            verticalSpacing(16),
            SmoothPageIndicator(
                controller: _controller,
                count: 2,
                effect: WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    dotColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    activeDotColor: Theme.of(context).colorScheme.primary)),
            verticalSpacing(16),
          ],
        )
      ],
    );
  }
}

/// The body of the [PageView] that displays specific leg results.
/// It contains the leg image with results, as well as hyperaesthesia and allodynia scores.
/// It also displays the total score for the leg.
class _PinPrickResultBody extends StatelessWidget {
  const _PinPrickResultBody({required this.leg, required this.results});
  final PinPrickLeg leg;
  final Map<String, int> results;

  @override
  Widget build(BuildContext context) {
    List<int> onlyPinPrickResults = results.entries
        .where((element) =>
            !element.key.contains(PinPrickLeg.left == leg
                ? PrickStrings.leftLegAllodynia.identifier
                : PrickStrings.righLegAllodynia.identifier) &&
            !element.key.contains(PinPrickLeg.left == leg
                ? PrickStrings.leftLegHyperaesthesia.identifier
                : PrickStrings.rightLegHyperaesthesia.identifier))
        .map(
          (e) => e.value,
        )
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          Languages.of(context)!.translate('common.${leg.name}-leg'),
          style: AppTextStyle.resultSectionLabelStyle,
        ),
        verticalSpacing(16),
        _getLegResultImage(leg, onlyPinPrickResults),
        verticalSpacing(16),
        StackedResultRow(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            items: [
              StackedResultItem(
                label: 'results.prick.allodynia',
                score: leg == PinPrickLeg.left
                    ? results[PrickStrings.leftLegAllodynia.identifier]!
                    : results[PrickStrings.righLegAllodynia.identifier]!,
                scoreZeroLabel: 'common.no',
                scoreOverZeroLabel: 'common.yes',
              ),
              StackedResultItem(
                label: 'results.prick.hyper',
                score: leg == PinPrickLeg.left
                    ? results[PrickStrings.leftLegHyperaesthesia.identifier]!
                    : results[PrickStrings.rightLegHyperaesthesia.identifier]!,
                scoreZeroLabel: 'common.no',
                scoreOverZeroLabel: 'common.yes',
              ),
              StackedResultItem(
                label: 'common.score',
                score: 0, // Irrelevant
                skipScoreCount: true,
                overrideScoreResult: Text(
                  results.values
                      .fold(0,
                          (previousValue, element) => previousValue + element)
                      .toString(),
                  style: AppTextStyle.regularIBM18sp,
                ),
              ),
            ]),
      ],
    );
  }
}

class _PinPrickLabelText extends StatelessWidget {
  final int score;

  const _PinPrickLabelText({required this.score});

  @override
  Widget build(BuildContext context) {
    imageLabelTextStyle(int score) {
      Color color = Theme.of(context).colorScheme.secondary;
      if (score != 0) {
        color = score == 1
            ? Theme.of(context).colorScheme.tertiary
            : Theme.of(context).colorScheme.error;
      }
      return AppTextStyle.regularIBM16sp.copyWith(
        fontWeight: FontWeight.bold,
        color: color,
      );
    }

    return Text(
      score.toString(),
      style: imageLabelTextStyle(score),
    );
  }
}

/// Enum to represent the left and right leg.
/// It is used both to retreive name as well as mark indexes of each leg in [PageView].
enum PinPrickLeg { left, right }

/// Returns the image of the leg with the results displayed on it.
/// It requires the [PinPrickLeg] and the results for that leg.
Stack _getLegResultImage(PinPrickLeg leg, List<int> results) {
  return Stack(children: [
    SizedBox(
      height: 230,
      child: Image.asset('assets/images/results/leg-results-${leg.name}.png'),
    ),
    Positioned(
      bottom: 0,
      left: leg == PinPrickLeg.left ? 48 : 90,
      child: _PinPrickLabelText(score: results[0]),
    ),
    Positioned(
      bottom: 30,
      left: leg == PinPrickLeg.left ? 108 : 40,
      child: _PinPrickLabelText(score: results[1]),
    ),
    Positioned(
      bottom: 72,
      left: leg == PinPrickLeg.left ? 106 : 40,
      child: _PinPrickLabelText(score: results[2]),
    ),
    Positioned(
      bottom: 105,
      left: leg == PinPrickLeg.left ? 84 : 58,
      child: _PinPrickLabelText(score: results[3]),
    ),
    Positioned(
      bottom: 140,
      left: leg == PinPrickLeg.left ? 60 : 85,
      child: _PinPrickLabelText(score: results[4]),
    ),
    Positioned(
      bottom: 190,
      left: 70,
      child: _PinPrickLabelText(score: results[5]),
    ),
  ]);
}
