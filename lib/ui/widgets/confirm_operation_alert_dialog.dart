import 'package:flutter/material.dart';
import 'package:neuro_planner/languages.dart';

class ConfirmOperationAlertDialog extends StatelessWidget {
  const ConfirmOperationAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.onCancel,
    this.confirmButtonChild,
  }) : super(key: key);

  final String title;
  final String content;
  final Function onConfirm;
  final Function? onCancel;
  final Text? confirmButtonChild;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: () {
              if (onCancel != null) onCancel!();
              Navigator.pop(context);
            },
            child: Text(Languages.of(context)!.translate('common.cancel'))),
        TextButton(
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
            child: confirmButtonChild == null
                ? Text(Languages.of(context)!.translate('settings.confirm'))
                : confirmButtonChild!),
      ],
    );
  }
}
