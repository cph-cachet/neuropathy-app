import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:neuropathy_grading_tool/repositories/settings_repository/settings_repository.dart';
import 'package:neuropathy_grading_tool/examination/steps/rp_vibration_step.dart';
import 'package:neuropathy_grading_tool/ui/widgets/semi_bold_text.dart';
import 'package:neuropathy_grading_tool/ui/widgets/spacing.dart';

import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';
import 'package:neuropathy_grading_tool/ui/widgets/vibration_button.dart';

class RPUIVibrationBodyWithButton extends StatefulWidget {
  final RPVibrationStep vibrationStep;
  final Widget toggleButton;

  const RPUIVibrationBodyWithButton({
    super.key,
    required this.vibrationStep,
    required this.toggleButton,
  });

  @override
  State<RPUIVibrationBodyWithButton> createState() =>
      _RPUIVibrationBodyWithButtonState();
}

class _RPUIVibrationBodyWithButtonState
    extends State<RPUIVibrationBodyWithButton> {
  final SettingsRepository _settingsRepository = GetIt.I.get();
  int _vibrationDuration = 15;

  @override
  void initState() {
    super.initState();
    _loadVibrationDuration();
  }

  void _loadVibrationDuration() async {
    int vibrationDuration = await _settingsRepository.getVibrationDuration();
    if (mounted) {
      setState(() => _vibrationDuration = vibrationDuration);
    }
  }

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
                child: widget.vibrationStep.vibrationSectionImage != null &&
                        widget.vibrationStep.vibrationSectionImage!.isNotEmpty
                    ? Image.asset(widget.vibrationStep.vibrationSectionImage!,
                        fit: BoxFit.cover)
                    : const Icon(Icons.error),
              ),
              Text(Languages.of(context)!.translate(widget.vibrationStep.title),
                  style: AppTextStyle.headline24sp),
            ],
          ),
          //verticalSpacing(8),
          //verticalSpacing(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: semiBoldText(
              widget.vibrationStep.text != null
                  ? Languages.of(context)!.translate(widget.vibrationStep.text!)
                  : '',
              AppTextStyle.regularIBM18sp,
              TextAlign.center,
            ),
          ),
          //verticalSpacing(24),
          VibrationButton(countDown: _vibrationDuration),
          //verticalSpacing(24),
          Text(
            Languages.of(context)!.translate('common.feel-vibration'),
            style: AppTextStyle.regularIBM18sp,
            textAlign: TextAlign.center,
          ),
          widget.toggleButton,
          verticalSpacing(8),
        ],
      ),
    );
  }
}
