// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

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

enum Sex {
  female('settings.sex.female', 'Female'),
  male('settings.sex.male', 'Male'),
  other('settings.sex.other', 'Other');

  const Sex(this.value, this.exportText);
  final String value;
  final String exportText;
}
