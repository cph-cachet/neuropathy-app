import 'package:neuropathy_grading_tool/repositories/settings_repository/patient.dart';

abstract class SettingsRepository {
  Future<Patient> getPatientInformation();
  Future insertPatientInfo(Patient patient);
  Future changePatientInfo(Map<String, dynamic> newValMap);
  Future setVibrationDuration(int newValue);
  Future<int> getVibrationDuration();
}
