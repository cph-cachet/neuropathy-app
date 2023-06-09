import 'dart:math';

import 'package:get_it/get_it.dart';
import 'package:neuro_planner/repositories/settings_repository/patient.dart';
import 'package:neuro_planner/repositories/settings_repository/settings_repository.dart';
import 'package:sembast/sembast.dart';

class SembastSettingsRepository extends SettingsRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = StoreRef.main();

  @override
  Future<Patient> getPatientInformation() async {
    final res = await _store.record('patient').get(_database);
    return res != null
        ? Patient.fromJson(res as Map<String, dynamic>)
        : Patient();
  }

  @override
  Future insertPatientInfo(Patient patient) async {
    await _store.record('patient').put(_database, patient.toJson());
  }

  @override
  Future<int> getVibrationDuration() {
    // TODO: implement getVibrationDuration
    throw UnimplementedError();
  }

  @override
  Future setVibrationDuration(int newValue) {
    // TODO: implement setVibrationDuration
    throw UnimplementedError();
  }

  @override
  Future changePatientInfo(Map<String, dynamic> newValMap) async {
    await _store.record('patient').update(_database, newValMap).then((value) =>
        {if (value == null) insertPatientInfo(Patient.fromJson(newValMap))});
  }
}
