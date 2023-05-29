import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:neuro_planner/languages.dart';
import 'package:neuro_planner/repositories/result_repository/result_repository.dart';
import 'package:neuro_planner/ui/main_page_empty.dart';
import 'package:neuro_planner/ui/main_page_examinations.dart';
import 'package:neuro_planner/ui/widgets/add_examination_button.dart';
import 'package:neuro_planner/utils/spacing.dart';
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
                    Text('Loading...'),
                    verticalSpacing(16),
                    CircularProgressIndicator(),
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
  Languages languages = Languages();
  List<RPTaskResult> _results = [];
  bool _hasLoaded = false;
  @override
  void initState() {
    _loadResults();
    super.initState();
  }

  _loadResults() async {
    // await _resultRepository
    //     .deleteAllResults(); //used for debug delete all results
    final results = await Future.delayed(
        const Duration(seconds: 1), () => _resultRepository.getResults());
    setState(() => _results = results);
    setState(() => _hasLoaded = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: _hasLoaded && _results.isNotEmpty
          ? const AddExaminationButton()
          : null,
      body: _hasLoaded
          ? _results.isNotEmpty
              ? MainPageBodyWithExaminations(
                  taskResults: _results, languages: languages)
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
