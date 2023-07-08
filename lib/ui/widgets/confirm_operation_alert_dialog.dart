import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/languages.dart';

/// An alert dialog that asks the user to confirm an operation.
///
/// It has a cancel and a confirm button. The confirm [TextButton] can be customized with the [confirmButtonChild] parameter,
/// otherwise it will display the 'Confirm' text (localized).
/// The cancel button will always be the 'Cancel' text (localized).
/// [onConfirm] and [onCancel] are the callbacks for the buttons.
/// If [onCancel] is null, when user clicks the button, the dialog will be dismissed.
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
