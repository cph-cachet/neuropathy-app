import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';
import 'package:research_package/research_package.dart';

/// A [ToggleButtons] widget that allows user to select an answer in a form of a split vertical button.
///
/// It sends the selected choice back to the parent widget with the [onPressed] callback.
/// Even though [ToggleButton] allows only one selection, the callback returns a list of [RPChoice]s,
/// so it can be immiediately passed as step result, following the research package convention.
/// The [RPChoiceAnswerFormat] is used to display the options.
/// Inital state is no selection, and after selecting one option, it cannot be brought back to no selection.
class ToggleButton extends StatefulWidget {
  final Function onPressed;
  final RPChoiceAnswerFormat answerFormat;

  const ToggleButton(
      {super.key, required this.onPressed, required this.answerFormat});

  @override
  ToggleButtonState createState() => ToggleButtonState();
}

class ToggleButtonState extends State<ToggleButton> {
  /// List of booleans that represent the selected state of each button, required for [ToggleButtons] widget.
  late List<bool> isSelected;

  /// List of selected choices, for the [onPressed] callback.
  late List<RPChoice> selectedChoices;

  @override
  void initState() {
    super.initState();
    // Initialize the list of booleans with false values, no option selected.
    isSelected =
        List.generate(widget.answerFormat.choices.length, (index) => false);
    selectedChoices = [];
  }

  void _onSelected(int index) {
    final selected = widget.answerFormat.choices[index];
    setState(() {
      for (int i = 0; i < isSelected.length; i++) {
        setState(() {
          isSelected[i] = i == index ? true : false;
        });
      }
    });

    // Only one choice allowed, no unchecking
    setState(() {
      selectedChoices = [];
      selectedChoices.add(selected);
    });

    selectedChoices.isNotEmpty
        ? widget.onPressed(selectedChoices)
        : widget.onPressed(null);
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
        direction: Axis.horizontal,
        onPressed: _onSelected,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        borderColor: Theme.of(context).colorScheme.primary,
        selectedColor: Colors.white,
        selectedBorderColor: Theme.of(context).colorScheme.primary,
        fillColor: Theme.of(context).colorScheme.primary,
        color: Theme.of(context).colorScheme.primary,
        constraints: const BoxConstraints(
          minHeight: 40.0,
          minWidth: 80.0,
        ),
        isSelected: isSelected,
        children: widget.answerFormat.choices
            .map((e) => Text(
                  Languages.of(context)!.translate(e.text).toUpperCase(),
                  style: ThemeTextStyle.toggleButtonStyle,
                ))
            .toList());
  }
}
