import 'dart:convert';

import 'package:flat/flat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neuro_planner/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Languages {
  final Locale locale;
  Languages({this.locale = const Locale.fromSubtags(languageCode: 'en')});
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  void keepLocaleKey(String localeKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('localeKey');
    await prefs.setString('localeKey', localeKey);
  }

  Future<String> readLocaleKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('localeKey') ?? 'en';
  }

  void setLocale(BuildContext context, Locale locale) async {
    keepLocaleKey(locale.languageCode);
    MyApp.setLocale(context, locale);
  }

  late Map<String, String> _localizedValues;

  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedValues =
        flatten(jsonMap).map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  static const LocalizationsDelegate<Languages> delegate = _LanguagesDelegate();

  String translate(String key) {
    return _localizedValues[key] ?? key;
  }
}

class _LanguagesDelegate extends LocalizationsDelegate<Languages> {
  const _LanguagesDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'da'].contains(locale.languageCode);
  }

  @override
  Future<Languages> load(Locale locale) async {
    Languages localizations = Languages(locale: locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_LanguagesDelegate old) => false;
}
