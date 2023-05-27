import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';

import '../examination_page.dart';
import '../languages.dart';
import '../utils/spacing.dart';
import '../utils/themes/text_styles.dart';

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
              'Welcome!',
              style: ThemeTextStyle.headline24sp.copyWith(
                height: 1.25,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpacing(48),
            Text(
              'You do not have any completed examinations yet.',
              style: ThemeTextStyle.headline24sp.copyWith(
                height: 1.25,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpacing(48),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(
                      builder: (context) => ExaminationPage())),
              child: Text(
                'Tap here to start a new one',
                style: ThemeTextStyle.headline24sp.copyWith(
                  height: 1.25,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            verticalSpacing(24),
            FloatingActionButton(
              child: const Icon(Icons.add_rounded, size: 36),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(
                      builder: (context) => ExaminationPage())),
            ),
            verticalSpacing(48),
            //Column(children:)
            // if (_results.isNotEmpty)
            //   ListView.builder(
            //     shrinkWrap: true,
            //     physics: const AlwaysScrollableScrollPhysics(),
            //     itemCount: _results.length,
            //     itemBuilder: (context, index) {
            //       final res = _results[index];
            //       //as RPStepResult;
            //       return Card(
            //         child: ListTile(
            //           leading: Icon(Icons.local_hospital),
            //           trailing: Icon(Icons.download),
            //           title: Text(
            //               dateFormatter.getFormattedTime(res.startDate!)),
            //         ),
            //       );
            //     },
            //   ),
            // Container(
            //     height: 200,
            //     child: ListView.builder(
            //         physics: const NeverScrollableScrollPhysics(),
            //         shrinkWrap: true,
            //         itemCount: _results.length,
            //         itemBuilder: (context, index) {
            //           final res = _results[index].results.values.first
            //               as RPStepResult;
            //           return Text(res.questionTitle);
            //         })), // Leaving here for debugging purposes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.4),
                  child: OutlinedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CircleFlag(
                            'gb',
                            size: 20,
                          ),
                        ),
                        Text('English'),
                      ],
                    ),
                    onPressed: () {
                      Languages.of(context)!.setLocale(context,
                          const Locale.fromSubtags(languageCode: 'en'));
                    },
                  ),
                ),
                horizontalSpacing(MediaQuery.of(context).size.width * 0.05),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.4),
                  child: OutlinedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: CircleFlag(
                            'dk',
                            size: 20,
                          ),
                        ),
                        Text('Dansk'),
                      ],
                    ),
                    onPressed: () {
                      Languages.of(context)!.setLocale(context,
                          const Locale.fromSubtags(languageCode: 'da'));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
