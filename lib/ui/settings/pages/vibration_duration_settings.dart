import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';

import '../../../languages.dart';
import '../../widgets/vibration_button.dart';

class VibrationSettingDialog extends StatefulWidget {
  VibrationSettingDialog(
      {super.key, required this.initialVibDuration, required this.onConfirm});

  @override
  State<VibrationSettingDialog> createState() => _VibrationSettingDialogState();
  final int initialVibDuration;
  final Function onConfirm;
  int? currentSetting;
}

class _VibrationSettingDialogState extends State<VibrationSettingDialog> {
  _changeVibration(int newValue) {
    if (newValue != widget.initialVibDuration) {
      setState(() {
        widget.currentSetting = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Vibration'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VibrationButton(
            countDown: widget.currentSetting ?? widget.initialVibDuration,
          ),
          InputQty(
              minVal: 1,
              initVal: widget.initialVibDuration,
              onQtyChanged: (val) => _changeVibration(val as int))
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(Languages.of(context)!.translate('common.cancel'))),
        TextButton(
            onPressed: () {
              if (widget.currentSetting != widget.initialVibDuration) {
                widget.onConfirm(widget.currentSetting);
              }
              Navigator.pop(context);
            },
            child: Text(Languages.of(context)!.translate('settings.confirm'))),
      ],
    );
  }
}
