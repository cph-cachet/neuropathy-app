import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:neuropathy_grading_tool/languages.dart';

class LocalizationsInj extends StatelessWidget {
  final Widget child;
  const LocalizationsInj({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        supportedLocales: const [
          Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
          Locale.fromSubtags(languageCode: 'da', countryCode: 'DK'),
        ],
        localizationsDelegates: const [
          Languages.delegate,
          //DefaultMaterialLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: const Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: child);
  }
}
