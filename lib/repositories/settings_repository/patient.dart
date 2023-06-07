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
  female('settings.sex.female'),
  male('settings.sex.male'),
  other('settings.sex.other');

  const Sex(this.value);
  final String value;
}
