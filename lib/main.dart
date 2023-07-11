import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:neuropathy_grading_tool/ui/home_page/home_page.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/ui/widgets/app_loading_indicator.dart';
import 'package:neuropathy_grading_tool/utils/themes/themes.dart';
import 'package:research_package/research_package.dart';
import 'init.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  /// Set new locale.
  /// The method is static so that it can be accessed from [Languages] class.
  ///
  /// While most translations are done with [Languages], some are performed with other delegates.
  /// For example, the [ResearchPackage] library uses its own localization delegate.
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Initialize the app resources.
  final Future _init = Init.initialize();

  /// The default locale is English.
  Locale _locale =
      const Locale.fromSubtags(languageCode: 'en', countryCode: 'US');

  /// Set new locale.
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

// Triggered when dependencies change, i.e. when the [_locale] is changed.
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final languages = Languages();
    final localeKey = await languages.readLocaleKey();

    /// Set the locale based on the saved locale key.
    if (localeKey == 'en') {
      setState(() {
        _locale =
            const Locale.fromSubtags(languageCode: 'en', countryCode: 'US');
      });
    } else if (localeKey == 'da') {
      setState(() {
        _locale =
            const Locale.fromSubtags(languageCode: 'da', countryCode: 'DK');
      });
    }
  }

  Languages languages = Languages();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Prevent the app from rotating.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      // Supported languages.
      supportedLocales: const [
        Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
        Locale.fromSubtags(languageCode: 'da', countryCode: 'DK'),
      ],
      localizationsDelegates: [
        Languages.delegate,
        RPLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: _locale,
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      title: 'Neuropathy Assessment Tool',
      theme: appTheme,
      home: FutureBuilder(
        // Build the app after the resources are loaded.
        // Minimum delay is 2 second to show the splash screen and prevent too quick change
        // That looks like glitching.
        future: Future.delayed(const Duration(seconds: 2), () => _init),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const HomePage(title: 'app-title');
          } else {
            // Splash screen.
            return const Scaffold(
              body: Center(child: AppLoadingIndicator(label: 'app-title')),
            );
          }
        },
      ),
    );
  }
}
