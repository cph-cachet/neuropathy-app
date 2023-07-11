import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/ui/settings/dialogs/vibration_duration_settings.dart';
import 'package:settings_ui/settings_ui.dart';

/// A settings tile for changing the vibration duration.
///
/// When pressed, shows a [VibrationSettingDialog] to allow the user to change the vibration duration.
/// It takes the initial vibration duration [initialVibDuration] and a callback [onConfirm] to be called when the user confirms the change.
/// [onConfirm] passes the new vibration duration to the parent.
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
