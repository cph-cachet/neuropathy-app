import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/repositories/settings_repository/patient.dart';
import 'package:neuropathy_grading_tool/ui/widgets/confirm_operation_alert_dialog.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';
import 'package:settings_ui/settings_ui.dart';

/// A settings tile for changing the patient's sex.
///
/// /// The tile displays the user's sex, and allows the user to change it.
/// As the application is meant to be used by one patient, modifying the sex
/// will clear the previous examination data. If the sex was not previously set, the data will not be cleared.
/// Before a modification that would clear the examinations,
/// the user is asked to confirm the operation with a [ConfirmOperationAlertDialog].
///
/// The tile is shown in the [SettingsPage]. It shows a bottom sheet modal with a picker when pressed.
/// It's parameters are the user's sex [patientSex] displayed on the tile
/// and a function [onChanged] that is called when the sex is changed.
/// [onChanged] callback passes two parameters to the parent: the new sex and a boolean indicating
/// whether the previous examination data should be cleared.
class SexSettingsTile extends AbstractSettingsTile {
  final String? patientSex;
  final Function onChanged;
  const SexSettingsTile(
      {super.key, required this.patientSex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    List<String> sexOptions = Sex.values.map((e) => e.value).toList();

    return SettingsTile(
        title: Text(Languages.of(context)!.translate('settings.sex.title')),
        value: !StringUtils.isNullOrEmpty(patientSex)
            ? Text(Languages.of(context)!.translate(patientSex!))
            : Text(
                Languages.of(context)!.translate('settings.sex.input'),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
        leading: const Icon(Icons.person),
        onPressed: (context) {
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 16, bottom: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        Languages.of(context)!
                            .translate('settings.sex.bottom-sheet-title'),
                        style: AppTextStyle.regularIBM18sp
                            .copyWith(color: Colors.black54),
                      ),
                      ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(Languages.of(context)!
                                .translate(sexOptions[index])),
                            onTap: () {
                              if (sexOptions[index] != patientSex) {
                                if (patientSex != null) {
                                  showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              ConfirmOperationAlertDialog(
                                                confirmButtonChild: Text(Languages
                                                        .of(context)!
                                                    .translate(
                                                        'settings.change-info-warning.button-change')),
                                                title: Languages.of(context)!
                                                    .translate(
                                                        'settings.change-info-warning.title'),
                                                content: Languages.of(context)!
                                                    .translate(
                                                        'settings.change-info-warning.text'),
                                                onConfirm: () {
                                                  onChanged(
                                                      sexOptions[index], true);
                                                },
                                              ))
                                      .then((_) => Navigator.pop(context));
                                } else {
                                  onChanged(sexOptions[index], false);
                                  Navigator.pop(context);
                                }
                              } else {
                                Navigator.pop(context);
                              }
                            },
                          );
                        },
                        itemCount: sexOptions.length,
                        shrinkWrap: true,
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
