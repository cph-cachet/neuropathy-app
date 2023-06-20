import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:settings_ui/settings_ui.dart';

import '../pages/vibration_duration_settings.dart';

class VibrationDurationSettingsTile extends AbstractSettingsTile {
  const VibrationDurationSettingsTile(
      {required this.onConfirm, required this.initialVibDuration, super.key});
  final Function onConfirm;
  final int initialVibDuration;

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
        title:
            Text(Languages.of(context)!.translate('settings.vibration.title')),
        leading: const Icon(Icons.vibration),
        value: Text(initialVibDuration != 0
            ? initialVibDuration.toString() +
                Languages.of(context)!.translate('settings.vibration.seconds')
            : ''),
        onPressed: (context) => {
              showDialog(
                  context: context,
                  builder: (context) => VibrationSettingDialog(
                        initialVibDuration: initialVibDuration,
                        onConfirm: (int val) => onConfirm(val),
                      ))
            });
  }
}
