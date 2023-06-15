import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:neuro_planner/survey/prick_part.dart';
import 'package:neuro_planner/ui/results/panels/vibration_panel.dart';
import 'package:neuro_planner/utils/spacing.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';
import 'package:research_package/research_package.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../languages.dart';

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

  Map<String, int> _getResultsForLeg(RPTaskResult result, String leg) {
    return Map.fromEntries(result.results.values
        .cast<RPStepResult>()
        .toList()
        .where((element) => pinPrickIdentifiers.contains(element.identifier))
        .where((element) => element.identifier.contains(leg))
        .map((e) =>
            MapEntry(e.identifier, e.results['answer'][0]['value'] as int)));
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
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
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
        'Pin prick',
        style: ThemeTextStyle.regularIBM20sp,
      ),
      leading: Icon(Icons.create, color: Theme.of(context).colorScheme.primary),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpacing(8),
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
              dif: 50,
              current: _isLeftSelected,
              first: true,
              second: false,
              borderWidth: 1,
              onChanged: (_) => _onSelected(_isLeftSelected ? 1 : 0),
              borderColor: Theme.of(context).colorScheme.primary,
              colorBuilder: (_) => Theme.of(context).colorScheme.primary,
              textBuilder: (value) => value
                  ? Center(
                      child: Text(
                          Languages.of(context)!
                              .translate('results.common.left')
                              .toUpperCase(),
                          style: ThemeTextStyle.extraLightIBM16sp.copyWith(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold)),
                    )
                  : Center(
                      child: Text(
                      Languages.of(context)!
                          .translate('results.common.right')
                          .toUpperCase(),
                      style: ThemeTextStyle.extraLightIBM16sp.copyWith(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    )),
            ),
            // ToggleButtons(
            //     direction: Axis.horizontal,
            //     onPressed: _onSelected,
            //     borderRadius: const BorderRadius.all(Radius.circular(20)),
            //     borderColor: Theme.of(context).colorScheme.primary,
            //     selectedColor: Colors.white,
            //     selectedBorderColor: Theme.of(context).colorScheme.primary,
            //     fillColor: Theme.of(context).colorScheme.primary,
            //     color: Theme.of(context).colorScheme.primary,
            //     constraints: const BoxConstraints(
            //       minHeight: 35.0,
            //       minWidth: 80.0,
            //     ),
            //     isSelected: _choices.map((e) => e.isSelected).toList(),
            //     children: _choices
            //         .map((e) => Text(
            //               Languages.of(context)!
            //                   .translate(e.text)
            //                   .toUpperCase(),
            //               style: ThemeTextStyle.toggleButtonStyle,
            //             ))
            //         .toList()),
            verticalSpacing(24),
            ConstrainedBox(
              //todo: change to sized box
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                  maxWidth: MediaQuery.of(context).size.width * 0.8),
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
        Stack(children: [
          SizedBox(
            //width: 250,
            height: 230,
            child: Image.asset(
                'assets/leg-results-${leg == PinPrickLeg.left ? 'left' : 'right'}.png'),
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
        StackedResultRow(items: [
          StackedResultItem(
            label: 'allodynia',
            score: leg == PinPrickLeg.left
                ? results[PrickStrings.leftLegAllodynia.identifier]!
                : results[PrickStrings.righLegAllodynia.identifier]!,
            translationSection: 'prick',
            scoreZeroLabel: 'common.no',
            scoreOverZeroLabel: 'common.yes',
          ),
          StackedResultItem(
            label: 'hyper',
            score: leg == PinPrickLeg.left
                ? results[PrickStrings.leftLegHyperaesthesia.identifier]!
                : results[PrickStrings.rightLegHyperaesthesia.identifier]!,
            translationSection: 'prick',
            scoreZeroLabel: 'common.no',
            scoreOverZeroLabel: 'common.yes',
          ),
          StackedResultItem(
            label: 'score',
            score: 0, // Irrelevant
            translationSection: 'common',
            skipScoreCount: true,
            overrideScoreResult: Text(
              results.values
                  .fold(0, (previousValue, element) => previousValue + element)
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

  const _PinPrickLabelText({super.key, required this.score});

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
