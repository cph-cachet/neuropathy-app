import 'package:basic_utils/basic_utils.dart';
import 'package:flag/flag.dart';

import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/utils/languages_local.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';
import 'package:settings_ui/settings_ui.dart';

/// A settings tile for changing the application language.
/// When pressed, show a modal bottom sheet with a list of languages to choose from.
///
/// It displays all the languages supported by the application, taking the ```supportedLocales``` list from the [MaterialApp].
/// Along the language name in native form, it displays the flag of the country the language is spoken in.
///
/// When a language is tapped, the new locale is set in [Languages], and the bottom sheet is dismissed.
class LanguagesSettingsTile extends AbstractSettingsTile {
  const LanguagesSettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    LanguageLocal lang = LanguageLocal();
    return SettingsTile(
        title:
            Text(Languages.of(context)!.translate('settings.language.title')),
        leading: const Icon(Icons.language),
        value: Text(StringUtils.capitalize(lang.getDisplayLanguage(
            Languages.of(context)!.locale.languageCode)["nativeName"])),
        onPressed: (context) {
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
              builder: (context) {
                List<Locale> supLocales = context
                        .findAncestorWidgetOfExactType<MaterialApp>()
                        ?.supportedLocales
                        .toList() ??
                    []; // get the supported locales from the MaterialApp
                List<String> languages = supLocales
                    .map((e) => e.languageCode)
                    .toList(); // get the language codes
                List<String> countryCodes = supLocales
                    .map((e) => e.countryCode?.toUpperCase() ?? "")
                    .toList(); // get the country codes
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 16, bottom: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          Languages.of(context)!
                              .translate('settings.language.title'),
                          style: AppTextStyle.regularIBM18sp.copyWith(
                            color: Colors.black54,
                          )),
                      ListView.builder(
                          itemCount: languages.length,
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              leading: Flag.fromString(countryCodes[index],
                                  height: 25, width: 25),
                              title: Text(StringUtils.capitalize(
                                  lang.getDisplayLanguage(
                                      languages[index])["nativeName"])),
                              onTap: () {
                                Languages.of(context)!.setLocale(
                                    context,
                                    Locale.fromSubtags(
                                        languageCode: languages[index]));
                                Navigator.pop(context);
                              },
                            );
                          })),
                    ],
                  ),
                );
              });
        });
  }
}
