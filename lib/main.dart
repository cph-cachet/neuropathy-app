import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:neuro_planner/languages.dart';
import 'package:neuro_planner/utils/spacing.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';
import 'examination_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale.fromSubtags(languageCode: 'en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final languages = Languages();
    final localeKey = await languages.readLocaleKey();
    if (localeKey == 'en') {
      setState(() {
        _locale = const Locale.fromSubtags(languageCode: 'en');
      });
    } else if (localeKey == 'da') {
      setState(() {
        _locale = const Locale.fromSubtags(languageCode: 'da');
      });
    }
  }

  Languages languages = Languages();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale.fromSubtags(languageCode: 'en'),
        Locale.fromSubtags(languageCode: 'da'),
      ],
      localizationsDelegates: const [
        Languages.delegate,
        //DefaultMaterialLocalizations.delegate,
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
      title: 'Flutter Demo',
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          //TODO: make this work on all buttons?
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          fillColor: MaterialStateProperty.all(Color(0xff22577a)),
          checkColor: MaterialStateProperty.all(Colors.white),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(Color(0xff22577a)),
        ),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff22577a),
          onPrimary: Colors.white,
          secondary: Colors.lightGreen,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.blue,
          surface: Colors.white70,
          onSurface: Colors.black,
        ),
      ),
      home: const MyHomePage(title: 'Neuropathy assesment'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
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
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(
                        builder: (context) => ExaminationPage())),
                child: Text(
                  Languages.of(context)!
                      .translate('welcome-screen.tap-to-start'),
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
