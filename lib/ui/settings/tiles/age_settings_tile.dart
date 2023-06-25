import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/ui/widgets/confirm_operation_alert_dialog.dart';
import 'package:settings_ui/settings_ui.dart';

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
