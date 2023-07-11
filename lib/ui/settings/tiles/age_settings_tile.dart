import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/ui/widgets/confirm_operation_alert_dialog.dart';
import 'package:settings_ui/settings_ui.dart';

/// A settings tile for changing the user's date of birth.
///
/// The tile displays the user's current age, and allows the user to change it.
/// As the application is meant to be used by one patient, modifying the date of birth
/// will clear the previous examination data. If the dob was not previously set, the data will not be cleared.
/// Before a modification that would clear the examinations,
/// the user is asked to confirm the operation with a [ConfirmOperationAlertDialog].
///
/// The tile is shown in the [SettingsPage]. It takes the user to a date picker when pressed.
/// It's parameters are the user's date of birth [dateOfBirth] to calculate user's age
/// and a function [onChanged] that is called when the date of birth is changed.
/// [onChanged] callback passes two parameters to the parent: the new date of birth and a boolean indicating
/// whether the previous examination data should be cleared.
class AgeSettingsTile extends AbstractSettingsTile {
  final DateTime? dateOfBirth;
  final Function onChanged;

  const AgeSettingsTile(this.dateOfBirth, this.onChanged, {super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
        leading: const Icon(Icons.calendar_month),
        title: Text(Languages.of(context)!.translate('settings.age.title')),
        value: dateOfBirth == null
            ? Text(Languages.of(context)!.translate('settings.age.input'),
                style: TextStyle(color: Theme.of(context).colorScheme.error))
            : Text(Jiffy.now()
                    .diff(Jiffy.parseFromDateTime(dateOfBirth!),
                        unit: Unit.year, asFloat: true)
                    .toString() +
                Languages.of(context)!.translate('settings.age.years')),
        onPressed: (context) {
          showDatePicker(
                  context: context,
                  initialDate: dateOfBirth ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now())
              .then((value) {
            if (value != null) {
              if (dateOfBirth != null) {
                showDialog(
                    context: context,
                    builder: (context) => ConfirmOperationAlertDialog(
                        title: Languages.of(context)!
                            .translate('settings.change-info-warning.title'),
                        content: Languages.of(context)!
                            .translate('settings.change-info-warning.text'),
                        confirmButtonChild: Text(
                          Languages.of(context)!.translate(
                              'settings.change-info-warning.button-change'),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error),
                        ),
                        onConfirm: () {
                          onChanged(value, true);
                        }));
              } else {
                onChanged(value, false);
              }
            }
          });
        });
  }
}
