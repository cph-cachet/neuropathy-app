import 'package:flutter/material.dart';

import '../examination_page.dart';
import '../languages.dart';
import '../utils/spacing.dart';
import '../utils/themes/text_styles.dart';
import 'package:neuropathy_grading_tool/ui/widgets/add_examination_button.dart';

class MainPageEmptyResults extends StatelessWidget {
  const MainPageEmptyResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Languages.of(context)!.translate('welcome-screen.welcome'),
              style: ThemeTextStyle.headline24sp.copyWith(
                height: 1.25,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpacing(48),
            Text(
              Languages.of(context)!.translate('welcome-screen.no-completed'),
              style: ThemeTextStyle.headline24sp.copyWith(
                height: 1.25,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpacing(48),
            Text(
              Languages.of(context)!.translate('welcome-screen.tap-to-start'),
              style: ThemeTextStyle.headline24sp.copyWith(
                height: 1.25,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpacing(24),
            const AddExaminationButton()
          ],
        ),
      ),
    );
  }
}
