import 'package:flutter/material.dart';

import 'helper_bottom_sheet.dart';

class BottomSheetButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Widget content;
  final String bottomSheetTitle;

  const BottomSheetButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.content,
      required this.bottomSheetTitle});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: (() {
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
              builder: (context) {
                return HelperBottomSheet(
                    title: bottomSheetTitle, content: content);
              });
        }),
        icon: icon,
        label: Text(label));
  }
}
