import 'dart:convert';

import 'package:flat/flat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neuropathy_grading_tool/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This class is used for localization.
/// It stores the preferred locale in the shared preferences.
class Languages {
  final Locale locale;
  Languages({this.locale = const Locale.fromSubtags(languageCode: 'en')});
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  /// This method is used to keep the locale key in the shared preferences.
  void keepLocaleKey(String localeKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('localeKey');
    await prefs.setString('localeKey', localeKey);
  }

  /// This method is used to read the locale key from the shared preferences.
  Future<String> readLocaleKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('localeKey') ?? 'en';
  }

  /// This method is used to set the locale.
  /// It saves the locale key in the shared preferences and sets the locale in the [MyApp] state.
  void setLocale(BuildContext context, Locale locale) async {
    keepLocaleKey(locale.languageCode);
    MyApp.setLocale(context, locale);
  }

  late Map<String, String> _localizedValues;

  /// This method loads the json file from the assets folder and stores the values in a map.
  /// The map is flattened, so that we can use a single key to get the string.
  /// Example:
  /// ```
  /// "common": { "yes": "Yes"} => "common.yes": "Yes"
  /// ```
  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    // flattening the map, so that we can use a single key to get the string.
    _localizedValues =
        flatten(jsonMap).map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  /// [LocalizationsDelegate] to be specified in the [MaterialApp.localizationsDelegates] list.
  /// It contains the [Languages] localization. Defines supported locales and a function to load the localized values.
  static const LocalizationsDelegate<Languages> delegate = _LanguagesDelegate();

  /// Retrieve the localized string from the localized values map.
  /// If the key is not found, it returns the key itself.
  ///
  /// When the _localizedValues are changed on locale change, the widgets are automatically updated.
  String translate(String key) {
    return _localizedValues[key] ?? key;
  }
}

///  [LocalizationsDelegate] to be specified in the [MaterialApp.localizationsDelegates] list.
/// It contains the [Languages] localization. Defines supported locales and a function to load the localized values.
class _LanguagesDelegate extends LocalizationsDelegate<Languages> {
  const _LanguagesDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'da'].contains(locale.languageCode);
  }

  /// Loads the localized values for the specified locale.
  @override
  Future<Languages> load(Locale locale) async {
    Languages localizations = Languages(locale: locale);
    await localizations.load();
    return localizations;
  }

  /// Prevent load on rebuild, not necessary for the app. Widgets update strings when the localizations map is changed
  /// automatically.
  @override
  bool shouldReload(_LanguagesDelegate old) => false;
}
