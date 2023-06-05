import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:neuro_planner/languages.dart';
import 'package:neuro_planner/repositories/result_repository/result_repository.dart';
import 'package:neuro_planner/ui/widgets/confirn_operation_alert_dialog.dart';
import 'package:neuro_planner/utils/generate_csv.dart';
import 'package:research_package/model.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});
  bool shouldReload = false;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ResultRepository _resultRepository = GetIt.I.get();
  List<RPTaskResult> _results = [];

  _loadResults() async {
    // await _resultRepository
    //     .deleteAllResults(); //used for debug delete all results
    final results = await Future.delayed(
        const Duration(seconds: 1), () => _resultRepository.getResults());
    setState(() => _results = results);
  }

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  @override
  Widget build(BuildContext context) {
    _resetDatabase() async {
      await _resultRepository.deleteAllResults();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          leading: IconButton(
              onPressed: () => Navigator.pop(context, widget.shouldReload),
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
              //TODO: move setting tiles to separate classes to clean up this file
              SettingsTile(
                  title: Text(
                    "Reset database",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                  leading: Icon(
                    Icons.delete_forever,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: (context) => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) =>
                          ConfirmOperationAlertDialog(
                              title: Languages.of(context)!
                                  .translate('settings.delete-database.title'),
                              content: Languages.of(context)!
                                  .translate('settings.delete-database.text'),
                              onConfirm: () {
                                _resetDatabase();
                                setState(() {
                                  widget.shouldReload = true;
                                });
                              },
                              confirmButtonChild: Text(
                                  Languages.of(context)!.translate(
                                      'settings.delete-database.button-delete'),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .error))))),
              SettingsTile(
                title: Text('Export data'),
                leading: Icon(Icons.import_export),
                onPressed: (context) {
                  CsvData csvData = CsvData.fromResults(_results);
                  exportCSV.myCSV(csvData.headers, csvData.rows);
                },
              )
            ],
          ),
        ]));
  }
}
