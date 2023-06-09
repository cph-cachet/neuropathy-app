import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:neuro_planner/languages.dart';
import 'package:neuro_planner/repositories/settings_repository/patient.dart';
import 'package:neuro_planner/ui/widgets/confirm_operation_alert_dialog.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';
import 'package:settings_ui/settings_ui.dart';

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
                        style: ThemeTextStyle.regularIBM18sp
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
