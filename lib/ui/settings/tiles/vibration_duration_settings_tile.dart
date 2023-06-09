import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../repositories/settings_repository/settings_repository.dart';
import '../pages/vibration_duration_settings.dart';

class VibrationDurationSettingsTile extends AbstractSettingsTile {
  const VibrationDurationSettingsTile(
      {required this.onConfirm, required this.initialVibDuration, super.key});
  final Function onConfirm;
  final int initialVibDuration;

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
        title: Text('Vibration Duration'),
        leading: Icon(Icons.vibration),
        value:
            Text(initialVibDuration != 0 ? initialVibDuration.toString() : ''),
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
