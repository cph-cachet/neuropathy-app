import 'package:flutter/material.dart';
import 'package:research_package/research_package.dart';

class RPUIPainSliderQuestionBody extends StatefulWidget {
  final RPSliderAnswerFormat answerFormat;
  final void Function(dynamic) onResultChange;

  const RPUIPainSliderQuestionBody(this.answerFormat, this.onResultChange,
      {super.key});

  @override
  RPUIPainSliderQuestionBodyState createState() =>
      RPUIPainSliderQuestionBodyState();
}

class RPUIPainSliderQuestionBodyState extends State<RPUIPainSliderQuestionBody>
    with AutomaticKeepAliveClientMixin<RPUIPainSliderQuestionBody> {
  double? value;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          Text('${widget.answerFormat.minValue.toInt()}'),
          Expanded(
            child: Slider(
              activeColor: Theme.of(context).sliderTheme.activeTrackColor,
              inactiveColor: Theme.of(context).sliderTheme.inactiveTrackColor,
              value: value ?? widget.answerFormat.minValue,
              onChanged: (double newValue) {
                setState(() {
                  value = newValue;
                });
                widget.onResultChange(value);
              },
              min: widget.answerFormat.minValue,
              max: widget.answerFormat.maxValue,
              divisions: widget.answerFormat.divisions,
            ),
          ),
          Text('${widget.answerFormat.maxValue.toInt()}')
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
