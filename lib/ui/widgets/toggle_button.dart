import 'package:flutter/material.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';

class ToggleButton extends StatefulWidget {
  final List<String> options;
  final Function onPressed;

  ToggleButton({super.key, required this.options, required this.onPressed});

  @override
  ToggleButtonState createState() => ToggleButtonState();
}

class ToggleButtonState extends State<ToggleButton> {
  late List<bool> _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = List.generate(widget.options.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
        direction: Axis.horizontal,
        onPressed: (int index) {
          setState(() {
            for (int i = 0; i < _isSelected.length; i++) {
              _isSelected[i] = i == index;
            }
          });
          widget.onPressed();
        },
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
        children: widget.options
            .map((e) => Text(
                  e,
                  style: ThemeTextStyle.toggleButtonStyle,
                ))
            .toList());
  }
}
