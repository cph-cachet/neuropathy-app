import 'package:avatar_glow/avatar_glow.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/repositories/result_repository/result_repository.dart';
import 'package:neuropathy_grading_tool/repositories/settings_repository/patient.dart';
import 'package:neuropathy_grading_tool/repositories/settings_repository/settings_repository.dart';
import 'package:neuropathy_grading_tool/ui/settings/settings.dart';
import 'package:neuropathy_grading_tool/ui/main_page_empty.dart';
import 'package:neuropathy_grading_tool/ui/main_page_examinations.dart';
import 'package:neuropathy_grading_tool/ui/widgets/add_examination_button.dart';
import 'package:neuropathy_grading_tool/utils/spacing.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';
import 'package:research_package/research_package.dart';
import 'init.dart';

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
  final Future _init = Init.initialize();

  //todo maybe move to Init?
  Locale _locale =
      const Locale.fromSubtags(languageCode: 'en', countryCode: 'US');

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
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      supportedLocales: const [
        Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
        Locale.fromSubtags(languageCode: 'da', countryCode: 'DK'),
      ],
      localizationsDelegates: [
        Languages.delegate,
        RPLocalizations.delegate,
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
        unselectedWidgetColor: const Color(0xff22577a).withOpacity(0.7),
        dividerColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Color(0xff22577a)),
          actionsIconTheme: IconThemeData(color: Color(0xff22577a)),
          shadowColor: Color(0xff22577a),
          // titleTextStyle: TextStyle(
          //   color: Color(0xff22577a),
          //   fontSize: 20,
          //   fontWeight: FontWeight.normal,
          // ),
          elevation: 0,
        ),
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
          fillColor: MaterialStateProperty.all(const Color(0xff22577a)),
          checkColor: MaterialStateProperty.all(Colors.white),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(const Color(0xff22577a)),
        ),
        iconTheme: const IconThemeData(color: Color(0xff22577a)),
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
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 1), () => _init),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const MyHomePage(title: 'Neuropathy assesment');
          } else {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Loading...'), // TODO: translate
                    verticalSpacing(16),
                    const CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          }
        },
      ),
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
  final ResultRepository _resultRepository = GetIt.I.get();
  final SettingsRepository _settingsRepository = GetIt.I.get();
  Languages languages = Languages();
  List<RPTaskResult> _results = [];
  Patient? _patient;

  bool _hasLoaded = false;
  @override
  void initState() {
    _initCountryCodes(context);
    _loadResults();
    _loadPatient();
    super.initState();
  }

  _loadPatient() async {
    Patient patient = await _settingsRepository.getPatientInformation();
    setState(() => _patient = patient);
  }

  _initCountryCodes(BuildContext context) async {
    await CountryCodes.init();
  }

  _loadResults() async {
    final results = await Future.delayed(
        const Duration(seconds: 1), () => _resultRepository.getResults());
    setState(() => _results = results);
    setState(() => _hasLoaded = true);
  }

  @override
  setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget _slideTransition(animation, child) {
    const begin = Offset(1.0, 0);
    const end = Offset.zero;
    const curve = Curves.ease;
    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final offsetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.title.toUpperCase(),
            style: ThemeTextStyle.extraLightIBM16sp.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                      .push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => SettingsScreen(),
                    transitionsBuilder: (_, animation, __, child) =>
                        _slideTransition(animation, child),
                  ))
                      .then((shouldReload) {
                    if (shouldReload == true) {
                      setState(() => _hasLoaded = false);
                      _loadResults();
                      _loadPatient();
                    }
                  }),
              icon: const Icon(Icons.settings_outlined))
        ],
      ),
      floatingActionButton: _hasLoaded && _results.isNotEmpty
          ? const AddExaminationButton()
          : null,
      body: _hasLoaded
          ? _results.isNotEmpty
              ? MainPageBodyWithExaminations(
                  taskResults: _results,
                  languages: languages,
                  patient: _patient ?? Patient(),
                )
              : const MainPageEmptyResults()
          : Center(
              child: AvatarGlow(
                  glowColor: Theme.of(context).colorScheme.primary,
                  endRadius: 50,
                  child: Icon(
                    Icons.book,
                    size: 50,
                    color: Theme.of(context).colorScheme.primary,
                  )),
            ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
