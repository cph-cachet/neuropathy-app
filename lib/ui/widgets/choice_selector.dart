// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:research_package/model.dart';

import '../../utils/themes/text_styles.dart';

class ChoiceSelector extends StatefulWidget {
  final Function(dynamic) onResultChange;
  final RPChoiceAnswerFormat answerFormat;

  const ChoiceSelector(
      {super.key, required this.onResultChange, required this.answerFormat});

  @override
  ChoiceSelectorState createState() => ChoiceSelectorState();
}

class ChoiceSelectorState extends State<ChoiceSelector> {
  late List<RPChoice> selectedChoices;

  @override
  void initState() {
    super.initState();
    selectedChoices = [];
  }

  //TODO: Parameter could be RPChoice instead of index
  void _onSelected(RPChoice selectedChoice) {
    if (widget.answerFormat.answerStyle == RPChoiceAnswerStyle.SingleChoice) {
      setState(() {
        selectedChoices = [];
        selectedChoices.add(selectedChoice);
      });
    } //TODO: Localize
    else {
      if (selectedChoices.contains(selectedChoice)) {
        setState(() {
          selectedChoices.remove(selectedChoice);
        });
      } else if (selectedChoice.text == "None of the above") {
        if (selectedChoices.contains(selectedChoice)) {
          setState(() {
            selectedChoices.remove(selectedChoice);
          });
        } else {
          setState(() {
            selectedChoices = [];
            selectedChoices.add(selectedChoice);
          });
        }
      } else {
        setState(() {
          selectedChoices
              .removeWhere((element) => element.text == "None of the above");
          selectedChoices.add(selectedChoice);
        });
      }
    }

    selectedChoices.isNotEmpty
        ? widget.onResultChange(selectedChoices)
        : widget.onResultChange([]);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.answerFormat.choices.length,
      itemBuilder: (BuildContext context, int index) {
        return _Choice(
          choice: widget.answerFormat.choices[index],
          answerStyle: widget.answerFormat.answerStyle,
          selected:
              selectedChoices.contains(widget.answerFormat.choices[index]),
          onSelected: _onSelected,
        );
        // return InkWell(
        //   onTap: () => _onSelected(widget.answerFormat.choices[index]),
        //   child: Row(
        //     children: [
        //       Checkbox(
        //         value: selectedChoices
        //             .contains(widget.answerFormat.choices[index]),
        //         onChanged: ((_) =>
        //             _onSelected(widget.answerFormat.choices[index])),
        //       ),
        //       Text(widget.answerFormat.choices[index].text),
        //     ],
        //   ),
        // );
      },
    );
  }
}

class _Choice extends StatelessWidget {
  final RPChoice choice;
  final RPChoiceAnswerStyle answerStyle;
  final bool selected;
  final Function(RPChoice) onSelected;
  const _Choice({
    Key? key,
    required this.choice,
    required this.answerStyle,
    required this.selected,
    required this.onSelected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (answerStyle == RPChoiceAnswerStyle.SingleChoice) {
      return InkWell(
        onTap: () => onSelected(choice),
        child: Row(
          children: [
            Transform.scale(
              scale: 1.7,
              child: Radio(
                groupValue: selected ? choice : null,
                value: choice,
                onChanged: (_) {
                  onSelected(choice);
                },
              ),
            ),
            Text(choice.text, style: ThemeTextStyle.regularIBM16sp),
          ],
        ),
      );
    } else {
      return InkWell(
        onTap: () => onSelected(choice),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 1.7,
              child: Checkbox(
                value: selected,
                onChanged: (_) {
                  onSelected(choice);
                },
              ),
            ),
            Text(choice.text, style: ThemeTextStyle.regularIBM16sp),
          ],
        ),
      );
    }
  }
}
