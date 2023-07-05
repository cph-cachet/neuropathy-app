// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

/// Information about the patient currently using the app. Json serializable.
///
/// The data consists of `DateTime` [dateOfBirth]  and a `String` [sex].
/// Both fields are optional.
///
/// The values and translation strings can be mapped from [Sex].
@JsonSerializable()
class Patient {
  DateTime? dateOfBirth;
  String? sex;
  Patient({
    this.dateOfBirth,
    this.sex,
  });

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}

/// Maps sex values and translation strings for [Patient] class.
///
/// Translation strings are used in the UI, while database stores the value.
/// When exporting data, the English value of [Sex] is exported.
enum Sex {
  female('settings.sex.female', 'Female'),
  male('settings.sex.male', 'Male'),
  other('settings.sex.other', 'Other');

  const Sex(this.value, this.exportText);
  final String value;
  final String exportText;
}
