import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:neuro_planner/languages.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back)),
        ),
        body: SettingsList(sections: [
          SettingsSection(
            title: Text("Personal information"),
            tiles: [
              SettingsTile.navigation(
                title: Text("Sex"),
                leading: Icon(Icons.person),
                value: Text("Female"),
                trailing: Icon(Icons.arrow_forward),
              ),
              SettingsTile.navigation(
                  title: Text("Email"), leading: Icon(Icons.calendar_month))
            ],
          ),
          SettingsSection(
            title: Text("Application"),
            tiles: [
              SettingsTile.navigation(
                title: Text("Language"),
                leading: Icon(Icons.language),
                value: Text(
                    CountryCodes.detailsForLocale(Languages.of(context)!.locale)
                            .localizedName ??
                        "English"),
              ),
            ],
          )
        ]));
  }
}
