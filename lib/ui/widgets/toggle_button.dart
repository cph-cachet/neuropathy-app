import 'package:flutter/material.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';
import 'package:research_package/research_package.dart';

class ToggleButton extends StatefulWidget {
  final Function onPressed;
  final RPChoiceAnswerFormat answerFormat;

  ToggleButton(
      {super.key, required this.onPressed, required this.answerFormat});

  @override
  ToggleButtonState createState() => ToggleButtonState();
}

class ToggleButtonState extends State<ToggleButton> {
  late List<bool> _isSelected;
  late List<RPChoice> selectedChoices;

  @override
  void initState() {
    super.initState();
    _isSelected =
        List.generate(widget.answerFormat.choices.length, (index) => false);
    selectedChoices = [];
  }

  void _onSelected(int index) {
    final selected = widget.answerFormat.choices[index];
    setState(() {
      for (int i = 0; i < _isSelected.length; i++) {
        if (i == index) {
          setState(() {
            _isSelected[i] = !_isSelected[i];
          });
        } else {
          setState(() {
            _isSelected[i] = false;
          });
        }
      }
    });
    if (selectedChoices.contains(selected)) {
      setState(() {
        selectedChoices.remove(selected);
      });
    } else {
      setState(() {
        selectedChoices = [];
        selectedChoices.add(selected);
      });
    }
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
        isSelected: _isSelected,
        children: widget.answerFormat.choices
            .map((e) => Text(
                  e.text.toUpperCase(),
                  style: ThemeTextStyle.toggleButtonStyle,
                ))
            .toList());
  }
}
