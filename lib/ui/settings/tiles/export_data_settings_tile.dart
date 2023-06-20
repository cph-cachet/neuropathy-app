import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:research_package/research_package.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:to_csv/to_csv.dart' as export_csv;
import '../../../repositories/settings_repository/patient.dart';
import '../../../utils/generate_csv.dart';

class ExportDataSettingTile extends AbstractSettingsTile {
  const ExportDataSettingTile(this._results, this._patient, {super.key});
  final List<RPTaskResult> _results;
  final Patient _patient;

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      title: Text(Languages.of(context)!.translate('settings.export-data')),
      leading: const Icon(Icons.import_export),
      onPressed: (context) {
        CsvData csvData = CsvData.fromResults(_results, _patient);
        export_csv.myCSV(csvData.headers, csvData.rows);
      },
    );
  }
}
