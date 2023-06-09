import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../languages.dart';
import '../../../repositories/result_repository/result_repository.dart';
import '../../widgets/confirm_operation_alert_dialog.dart';

class ResetDatabaseSettingsTile extends AbstractSettingsTile {
  final void onShouldReload;
  const ResetDatabaseSettingsTile(this.onShouldReload, {super.key});

  @override
  Widget build(BuildContext context) {
    final ResultRepository resultRepository = GetIt.I.get();
    resetDatabase() async {
      await resultRepository.deleteAllResults();
    }

    return SettingsTile(
        title: Text(
          Languages.of(context)!.translate("settings.reset-database"),
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        leading: Icon(
          Icons.delete_forever,
          color: Theme.of(context).colorScheme.error,
        ),
        onPressed: (context) => showDialog<String>(
            context: context,
            builder: (BuildContext context) => ConfirmOperationAlertDialog(
                title: Languages.of(context)!
                    .translate('settings.delete-database.title'),
                content: Languages.of(context)!
                    .translate('settings.delete-database.text'),
                onConfirm: () {
                  resetDatabase();
                  onShouldReload;
                },
                confirmButtonChild: Text(
                    Languages.of(context)!
                        .translate('settings.delete-database.button-delete'),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.error)))));
  }
}
