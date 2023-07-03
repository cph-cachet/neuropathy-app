import 'package:neuropathy_grading_tool/repositories/settings_repository/patient.dart';

abstract class SettingsRepository {
  /// Returns the patient information stored in the settings database in form of [Patient] object.
  ///
  /// If no patient information is stored, an empty [Patient] object is returned.
  Future<Patient> getPatientInformation();

  /// Inserts the [Patient] information into the settings database.
  /// Overwrites all existing patient information.
  ///
  /// Provided [Patient] object must not be null, but can contain null fields.
  Future insertPatientInfo(Patient patient);

  /// Updates the [Patient] information stored in the settings database.
  /// Can be used to update single fields or all fields at once.
  /// May be used even if no patient information is stored in the database.
  ///
  /// Provided [Map] must not be null, it has to contain at least one key-value pair matching one of the fields of [Patient].
  /// The value of the key-value pair must be of the same type as the field of [Patient] it is meant to update.
  /// Example of the [Map] that can be used to update the [Patient] object: ```{'sex': 'female'}```
  Future changePatientInfo(Map<String, dynamic> newValMap);

  /// Writes the vibration duration to the settings database.
  ///
  /// Overwrites any existing vibration duration.
  /// The value is stored as [int], and meant to specify seconds.
  Future setVibrationDuration(int newValue);

  /// Returns the vibration duration stored in the settings database.
  ///
  /// If no vibration duration is stored, the default value of 15 is returned.
  /// The value is stored as [int], and meant to specify seconds.
  Future<int> getVibrationDuration();
}
