import 'package:flutter/material.dart';
import 'package:neuro_planner/step/steps/rp_vibration_step.dart';
import 'package:neuro_planner/utils/spacing.dart';

import '../../utils/themes/text_styles.dart';
import '../widgets/vibration_button.dart';

class RPUIVibrationBodyWithButton extends StatelessWidget {
  final RPVibrationStep vibrationStep;
  final Widget toggleButton;

  RPUIVibrationBodyWithButton({
    super.key,
    required this.vibrationStep,
    required this.toggleButton,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.35),
                child: vibrationStep.vibrationSection != null &&
                        vibrationStep.vibrationSection!.isNotEmpty
                    ? Image.asset(vibrationStep.vibrationSection!,
                        fit: BoxFit.cover)
                    : const Icon(Icons.error),
              ),
              Text(vibrationStep.title, style: ThemeTextStyle.headline24sp),
            ],
          ),
          //verticalSpacing(8),
          //verticalSpacing(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              vibrationStep.text ?? '',
              style: ThemeTextStyle.regularIBM18sp,
              textAlign: TextAlign.center,
            ),
          ),
          //verticalSpacing(24),
          const VibrationButton(),
          //verticalSpacing(24),
          Text(
            'Can you feel the vibration?',
            style: ThemeTextStyle.regularIBM18sp,
            textAlign: TextAlign.center,
          ),
          toggleButton,
          verticalSpacing(8),
        ],
      ),
    );
  }
}
