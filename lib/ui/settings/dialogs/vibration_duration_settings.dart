import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/ui/widgets/vibration_button.dart';
import 'package:neuropathy_grading_tool/ui/widgets/spacing.dart';
import 'package:neuropathy_grading_tool/utils/themes/styles.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';

/// A dialog that allows the user to change the vibration duration. Since different devices
/// have different allowed vibration duration, the user can test the vibration duration on their device.
///
/// The dialog is shown when the user presses the vibration duration setting
/// tile in the settings page.
/// The dialog contains a picker where the user can enter a number between 5 and 30 seconds or use the
/// plus and minus buttons to change the value.
/// The dialog also contains a button that allows the user to test the vibration.
class VibrationSettingDialog extends StatefulWidget {
  const VibrationSettingDialog(
      {super.key, required this.initialVibDuration, required this.onConfirm});

  @override
  State<VibrationSettingDialog> createState() => _VibrationSettingDialogState();
  final int initialVibDuration;
  final Function onConfirm;
}

class _VibrationSettingDialogState extends State<VibrationSettingDialog> {
  int? currentSetting;

  _changeVibration(int newValue) {
    if (!(newValue == widget.initialVibDuration && currentSetting == null)) {
      setState(() {
        currentSetting = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        Languages.of(context)!.translate('settings.vibration.title'),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            Languages.of(context)!.translate('settings.vibration.text'),
            textAlign: TextAlign.center,
          ),
          verticalSpacing(16),
          InputQty(
              maxVal: 30,
              btnColor1: Theme.of(context).colorScheme.primary,
              showMessageLimit: false,
              boxDecoration: const BoxDecoration(),
              borderShape: BorderShapeBtn.circle,
              minVal: 5,
              initVal: widget.initialVibDuration,
              onQtyChanged: (val) => _changeVibration(val as int)),
          Text(Languages.of(context)!.translate('settings.vibration.seconds'),
              style: AppTextStyle.regularIBM14sp.copyWith(
                  fontStyle: FontStyle.italic, color: Colors.black54)),
          verticalSpacing(16),
          VibrationButton(
            countDown: currentSetting ?? widget.initialVibDuration,
          ),
        ],
      ),
      //actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              Languages.of(context)!.translate('common.cancel'),
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            )),
        ElevatedButton(
            style: Styles.roundedButtonStyle,
            onPressed: () {
              if (currentSetting != widget.initialVibDuration &&
                  currentSetting != null) {
                widget.onConfirm(currentSetting);
              }
              Navigator.pop(context);
            },
            child: Text(Languages.of(context)!.translate('settings.confirm'))),
      ],
    );
  }
}
