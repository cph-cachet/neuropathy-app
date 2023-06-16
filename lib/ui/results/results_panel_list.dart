import 'package:flutter/material.dart';
import 'package:neuro_planner/survey/vibration_part.dart';
import 'package:neuro_planner/ui/results/tiles/panel_item.dart';
import 'package:neuro_planner/ui/results/tiles/vibration_panel.dart';
import 'package:research_package/research_package.dart';

class ResultsPanelList extends StatefulWidget {
  const ResultsPanelList(
      {super.key, required this.panelItems, required this.result});
  final List<PanelItem> panelItems;
  final RPTaskResult result;

  @override
  State<ResultsPanelList> createState() => _ResultsPanelListState();
}

class _ResultsPanelListState extends State<ResultsPanelList> {
  late Map<String, int> vibrationScores = Map.fromEntries(widget
      .result.results.values
      .cast<RPStepResult>()
      .toList()
      .where((element) => allVibrationIdentifiers.contains(element.identifier))
      .map((e) =>
          MapEntry(e.identifier, e.results['answer'][0]['value'] as int)));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.panelItems[index].isExpanded = !isExpanded;
        });
      },
      children: [
        ExpansionPanel(
            canTapOnHeader: true,
            headerBuilder: (context, isExpanded) =>
                PanelItemHeaderWidget(panelItem: widget.panelItems[0]),
            body: VibrationPanelBody(vibrationScores: vibrationScores),
            isExpanded: widget.panelItems[0].isExpanded),
      ],
    ));
  }
}
