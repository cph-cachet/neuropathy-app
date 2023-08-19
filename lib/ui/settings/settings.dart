import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/repositories/result_repository/result_repository.dart';
import 'package:neuropathy_grading_tool/repositories/settings_repository/settings_repository.dart';
import 'package:neuropathy_grading_tool/ui/settings/tiles/age_settings_tile.dart';
import 'package:neuropathy_grading_tool/ui/settings/tiles/export_data_settings_tile.dart';
import 'package:neuropathy_grading_tool/ui/settings/tiles/language_settings_tile.dart';
import 'package:neuropathy_grading_tool/ui/settings/tiles/reset_database_settings_tile.dart';
import 'package:neuropathy_grading_tool/ui/settings/tiles/sex_settings_tile.dart';
import 'package:neuropathy_grading_tool/ui/settings/tiles/vibration_duration_settings_tile.dart';
import 'package:research_package/model.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:neuropathy_grading_tool/repositories/settings_repository/patient.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';

/// A screen for changing the application settings.
///
/// It displays the user's current settings and allows the user to change them.
/// The settings are divided into two sections: personal information and application settings.
/// The [SettingsScreen] is responsible for loading the user's current settings and passing them to the child tiles.
/// It loads both [SettingRepository] and [ResultRepository] data.
/// It also handles the user's input and passes it to the repositories to be saved.
///
/// The [willReload] boolean is used to indicate whether the home page should reload the data after navigating back to it.
/// It is passed to the home page when the popping the current context.
/// It is set to true when the user changes settings that impact the examination results data.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ResultRepository _resultRepository = GetIt.I.get();
  final SettingsRepository _settingsRepository = GetIt.I.get();
  List<RPTaskResult> _results = [];
  Patient? _patient;
  bool willReload = false;
  int vibrationDuration = 0;

  /// load the results from the database
  _loadResults() async {
    final results = await Future.delayed(
        const Duration(seconds: 1), () => _resultRepository.getResults());
    setState(() => _results = results);
  }

  /// set the patient info to the database
  _setPatient(Patient patient) async {
    await _settingsRepository.insertPatientInfo(patient);
    _getPatient();
  }

  /// get the patient info from the database
  _getPatient() async {
    final patient = await _settingsRepository.getPatientInformation();
    setState(() => _patient = patient);
  }

  /// change the patient info in the database
  _changePatientInfo(Map<String, dynamic> newValue) async {
    await _settingsRepository.changePatientInfo(newValue);
    _getPatient();
  }

  /// delete all results from the database
  _resetDatabase() async {
    await _resultRepository.deleteAllResults();
  }

  /// set the vibration duration in the database
  _setVibrationDuration(int val) async {
    await _settingsRepository.setVibrationDuration(val);
    _getVibrationDuration();
  }

  /// get the vibration duration from the database
  _getVibrationDuration() async {
    int val = await _settingsRepository.getVibrationDuration();
    setState(() {
      vibrationDuration = val;
    });
  }

  /// set the [willReload] boolean to true to indicate that the home page should reload the data
  _shouldReload() {
    setState(() {
      willReload = true;
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    _getPatient();
    _getVibrationDuration();
    _loadResults();
    willReload = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              Languages.of(context)!.translate('settings.title').toUpperCase(),
              style: AppTextStyle.extraLightIBM16sp.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold)),
          leading: IconButton(
              onPressed: () => Navigator.pop(context, willReload),
              icon: const Icon(Icons.arrow_back)),
        ),
        body: SettingsList(
            lightTheme: const SettingsThemeData(
              settingsListBackground: Colors.transparent,
            ),
            sections: [
              SettingsSection(
                title: Text(Languages.of(context)!
                    .translate('settings.sections.personal-info')),
                tiles: [
                  if (kDebugMode)
                    SettingsTile(
                        title: const Text(
                            'reset patient info w/out deleting results'),
                        onPressed: (_) =>
                            _setPatient(Patient())), // debug mode only
                  SexSettingsTile(
                      patientSex: _patient?.sex,
                      onChanged: (newValue, reset) {
                        _changePatientInfo({'sex': newValue});
                        if (reset) _resetDatabase();
                        _shouldReload();
                      }),
                  AgeSettingsTile(_patient?.dateOfBirth,
                      (DateTime newValue, reset) {
                    _changePatientInfo(
                        {'dateOfBirth': newValue.toIso8601String()});
                    if (reset) _resetDatabase();
                    _shouldReload();
                  })
                ],
              ),
              SettingsSection(
                title: Text(
                    Languages.of(context)!.translate('settings.sections.app')),
                tiles: [
                  const LanguagesSettingsTile(),
                  ExportDataSettingTile(_results, _patient ?? Patient()),
                  ResetDatabaseSettingsTile(
                    onShouldReload: () {
                      _shouldReload();
                      _setPatient(Patient());
                      _loadResults();
                    },
                  ),
                  VibrationDurationSettingsTile(
                    initialVibDuration: vibrationDuration,
                    onConfirm: (val) => _setVibrationDuration(val),
                  )
                ],
              ),
            ]));
  }
}
