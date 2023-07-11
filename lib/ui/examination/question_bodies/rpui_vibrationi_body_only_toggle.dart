import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/examination/steps/rp_vibration_step.dart';
import 'package:neuropathy_grading_tool/ui/widgets/bottom_sheet_button.dart';
import 'package:neuropathy_grading_tool/ui/widgets/semi_bold_text.dart';
import 'package:neuropathy_grading_tool/ui/widgets/spacing.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';

class RPUIVibrationBodyOnlyToggle extends StatelessWidget {
  final RPVibrationStep vibrationStep;
  final Widget toggleButton;

  const RPUIVibrationBodyOnlyToggle(
      {super.key, required this.vibrationStep, required this.toggleButton});

  @override
  Widget build(BuildContext context) {
    return Material(
      textStyle: AppTextStyle.headline24sp,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(Languages.of(context)!.translate(vibrationStep.title)),
              Text(Languages.of(context)!.translate('extension.text-1')),
              semiBoldText(
                  Languages.of(context)!
                      .translate('extension.text-2-${vibrationStep.text}'),
                  AppTextStyle.headline24sp,
                  TextAlign.center),
              Column(
                children: [
                  Text(Languages.of(context)!.translate('extension.text-3'),
                      textAlign: TextAlign.center),
                  verticalSpacing(8),
                  BottomSheetButton(
                    icon: const Icon(
                      Icons.help_outline_rounded,
                      size: 20,
                    ),
                    label: Languages.of(context)!.translate('common.more-info'),
                    bottomSheetTitle: Languages.of(context)!
                        .translate('extension.bottom-sheet-title'),
                    content: Column(
                      children: [
                        Text(
                          Languages.of(context)!
                              .translate('extension.bottom-sheet-text-1'),
                          style: AppTextStyle.regularIBM20sp,
                          textAlign: TextAlign.justify,
                        ),
                        verticalSpacing(24),
                        semiBoldText(
                            Languages.of(context)!
                                .translate('extension.bottom-sheet-text-2'),
                            AppTextStyle.regularIBM20sp,
                            TextAlign.justify),
                        verticalSpacing(24),
                        Text(
                          style: AppTextStyle.regularIBM20sp,
                          textAlign: TextAlign.justify,
                          Languages.of(context)!
                              .translate('extension.bottom-sheet-text-3'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              toggleButton,
            ],
          ),
        ),
      ),
    );
  }
}
