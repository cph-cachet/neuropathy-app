import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/ui/widgets/spacing.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';

/// A loading indicator that is displayed when the app is loading.
/// Displays a text and a loading indicator.
class AppLoadingIndicator extends StatelessWidget {
  final String label;
  const AppLoadingIndicator({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Languages.of(context)!.translate(label).toUpperCase(),
            style: AppTextStyle.extraLightIBM16sp.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold)),
        verticalSpacing(32),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.4),
          child: const LoadingIndicator(
              indicatorType: Indicator.lineScalePulseOut),
        ),
      ],
    );
  }
}
