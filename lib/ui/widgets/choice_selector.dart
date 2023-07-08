// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';
import 'package:research_package/model.dart';

/// A widget that allows the user to select one or more choices from a list.
///
/// The choices are provided with [RPChoiceAnswerFormat] to display the options.
/// The user can select one or more choices, depending on the [RPChoiceAnswerStyle].
/// The style is dependent on single or multiple choice, rendering the checkboxes
/// as circles or squares respectively. It sends the selected choices back to the parent widget
/// with the [onResultChange] callback.
///
/// Multiple-choice only: If the user selects the 'None of the above' option, all other options are deselected.
/// That option is recognized if it's [RPChoice].text is ``` 'common.none-of-the-above' ```.
/// Single-choice only: After the user selects an option, the widget cannot be brought back to no selection initial state.
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

  /// Callback function for the [_Choice] widget.
  /// It updates the [selectedChoices] list, and sends it back to the parent widget.
  /// Contains the choice logic for single and multiple choice.
  void _onSelected(RPChoice selectedChoice) {
    if (widget.answerFormat.answerStyle == RPChoiceAnswerStyle.SingleChoice) {
      setState(() {
        selectedChoices = [];
        selectedChoices.add(selectedChoice);
      });
    } else {
      if (selectedChoices.contains(selectedChoice)) {
        setState(() {
          selectedChoices.remove(selectedChoice);
        });
      } else if (selectedChoice.text == 'common.none-of-the-above') {
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
          selectedChoices.removeWhere(
              (element) => element.text == 'common.none-of-the-above');
          selectedChoices.add(selectedChoice);
        });
      }
    }

    selectedChoices.isNotEmpty
        ? widget.onResultChange(selectedChoices)
        : widget.onResultChange(null);
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
      },
    );
  }
}

/// A widget that displays a single option.
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
    return InkWell(
      onTap: () => onSelected(choice),
      child: Row(
        children: [
          answerStyle == RPChoiceAnswerStyle.SingleChoice
              ? Transform.scale(
                  scale: 1.7,
                  child: Radio(
                    groupValue: selected ? choice : null,
                    value: choice,
                    onChanged: (_) {
                      onSelected(choice);
                    },
                  ),
                )
              : Transform.scale(
                  scale: 1.7,
                  child: Checkbox(
                    value: selected,
                    onChanged: (_) {
                      onSelected(choice);
                    },
                  ),
                ),
          Expanded(
            child: Text(Languages.of(context)!.translate(choice.text),
                style: AppTextStyle.regularIBM16sp),
          ),
        ],
      ),
    );
  }
}
