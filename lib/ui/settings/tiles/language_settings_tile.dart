import 'package:basic_utils/basic_utils.dart';
import 'package:flag/flag.dart';

import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/utils/languages_local.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';
import 'package:settings_ui/settings_ui.dart';

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
                    [];
                List<String> languages =
                    supLocales.map((e) => e.languageCode).toList();
                List<String> countryCodes = supLocales
                    .map((e) => e.countryCode?.toUpperCase() ?? "")
                    .toList();
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 16, bottom: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          Languages.of(context)!
                              .translate('settings.language.title'),
                          style: ThemeTextStyle.regularIBM18sp.copyWith(
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
