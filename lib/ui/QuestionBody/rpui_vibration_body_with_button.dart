import 'package:flutter/material.dart';
import 'package:neuro_planner/step/steps/rp_vibration_step.dart';
import 'package:neuro_planner/ui/widgets/semi_bold_text.dart';
import 'package:neuro_planner/utils/spacing.dart';

import '../../languages.dart';
import '../../utils/themes/text_styles.dart';
import '../widgets/vibration_button.dart';

class RPUIVibrationBodyWithButton extends StatelessWidget {
  final RPVibrationStep vibrationStep;
  final Widget toggleButton;

  const RPUIVibrationBodyWithButton({
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
              Text(Languages.of(context)!.translate(vibrationStep.title),
                  style: ThemeTextStyle.headline24sp),
            ],
          ),
          //verticalSpacing(8),
          //verticalSpacing(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: semiBoldText(
              vibrationStep.text != null
                  ? Languages.of(context)!.translate(vibrationStep.text!)
                  : '',
              ThemeTextStyle.regularIBM18sp,
              TextAlign.center,
            ),
          ),
          //verticalSpacing(24),
          VibrationButton(),
          //verticalSpacing(24),
          Text(
            Languages.of(context)!.translate('common.feel-vibration'),
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
