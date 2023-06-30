import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/survey/prick_part.dart';

import 'package:neuropathy_grading_tool/ui/widgets/neuropathy_icons.dart';
import 'package:neuropathy_grading_tool/ui/widgets/stacked_result_item.dart';
import 'package:neuropathy_grading_tool/utils/spacing.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';
import 'package:research_package/research_package.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PinPrickTile extends StatefulWidget {
  const PinPrickTile({super.key, required this.result});
  final RPTaskResult result;

  @override
  State<PinPrickTile> createState() => _PinPrickTileState();
}

class _PinPrickTileState extends State<PinPrickTile> {
  final _controller = PageController();
  late List<_PinPrickChoice> _choices;
  bool _isLeftSelected = true;

  Map<String, int> _getResults(RPTaskResult result) {
    return Map.fromEntries(result.results.values
        .cast<RPStepResult>()
        .toList()
        .where((element) => pinPrickIdentifiers.contains(element.identifier))
        .map((e) =>
            MapEntry(e.identifier, e.results['answer'][0]['value'] as int)));
  }

  Map<String, int> _getResultsForLeg(RPTaskResult result, String leg) {
    Map<String, int> pinprickScores = _getResults(result);
    return Map.fromEntries(
        pinprickScores.entries.where((element) => element.key.contains(leg)));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _choices = [
        _PinPrickChoice(
            text: 'left',
            isSelected: true,
            result: _getResultsForLeg(widget.result, 'left')),
        _PinPrickChoice(
            text: 'right',
            isSelected: false,
            result: _getResultsForLeg(widget.result, 'right'))
      ];
    });
  }

  void _onSelected(int index) {
    _controller.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    setState(() {
      _isLeftSelected = index == 0;
      _choices[index].isSelected = true;
      _choices[index == 0 ? 1 : 0].isSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        Languages.of(context)!.translate('results.prick.title'),
        style: ThemeTextStyle.regularIBM20sp,
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
              style: ThemeTextStyle.resultsLabelsStyle,
            ),
            Text(
              _getResults(widget.result)
                  .values
                  .fold(0, (previousValue, element) => previousValue + element)
                  .toString(),
              style: ThemeTextStyle.headline24sp,
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
                onChanged: (_) => _onSelected(_isLeftSelected ? 1 : 0),
                borderColor: Theme.of(context).colorScheme.primary,
                colorBuilder: (_) => Theme.of(context).colorScheme.primary,
                textBuilder: (_) => Center(
                      child: Text(
                          Languages.of(context)!
                              .translate('results.prick.switch-leg')
                              .toUpperCase(),
                          style: ThemeTextStyle.extraLightIBM16sp.copyWith(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold)),
                    )),
            verticalSpacing(24),
            ConstrainedBox(
              //TODO: change to sized box
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                  maxWidth: MediaQuery.of(context).size.width * 0.9),
              child: PageView(
                onPageChanged: (index) => _onSelected(index),
                controller: _controller,
                children: [
                  _PinPrickResultBody(
                      leg: PinPrickLeg.left, results: _choices[0].result),
                  _PinPrickResultBody(
                      leg: PinPrickLeg.right, results: _choices[1].result)
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
          style: ThemeTextStyle.resultsLabelsStyle,
        ),
        verticalSpacing(16),
        Stack(children: [
          SizedBox(
            //width: 250,
            height: 230,
            child: Image.asset(
                'assets/images/results/leg-results-${leg == PinPrickLeg.left ? 'left' : 'right'}.png'),
          ),
          Positioned(
            bottom: 0,
            left: leg == PinPrickLeg.left ? 48 : 90,
            child: _PinPrickLabelText(score: onlyPinPrickResults[0]),
          ),
          Positioned(
            bottom: 30,
            left: leg == PinPrickLeg.left ? 108 : 40,
            child: _PinPrickLabelText(score: onlyPinPrickResults[1]),
          ),
          Positioned(
            bottom: 72,
            left: leg == PinPrickLeg.left ? 106 : 40,
            child: _PinPrickLabelText(score: onlyPinPrickResults[2]),
          ),
          Positioned(
            bottom: 105,
            left: leg == PinPrickLeg.left ? 84 : 58,
            child: _PinPrickLabelText(score: onlyPinPrickResults[3]),
          ),
          Positioned(
            bottom: 140,
            left: leg == PinPrickLeg.left ? 60 : 85,
            child: _PinPrickLabelText(score: onlyPinPrickResults[4]),
          ),
          Positioned(
            bottom: 190,
            left: 70,
            child: _PinPrickLabelText(score: onlyPinPrickResults[5]),
          ),
        ]),
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
                  style: ThemeTextStyle.regularIBM18sp,
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
            ? Colors.orange
            : Theme.of(context).colorScheme.error; //TODO add orange to theme
      }
      return ThemeTextStyle.regularIBM16sp.copyWith(
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

class _PinPrickChoice {
  _PinPrickChoice(
      {required this.text, this.isSelected = false, this.result = const {}});
  final String text;
  bool isSelected;
  Map<String, int> result;
}

enum PinPrickLeg { left, right }
