import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/utils/spacing.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';

/// A bottom sheet that displays a [title] and [content].
///
/// It is used to display more information about a step or explain instructions.
/// The [title] is displayed in the top left corner, and the [content] is displayed below it.
class HelperBottomSheet extends StatelessWidget {
  final String title;
  final Widget content;

  const HelperBottomSheet(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            16, 8, 16, 16), //  .symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.help_outline_rounded,
                    color: Colors.black54, size: 20),
                horizontalSpacing(8),
                Text(
                  title,
                  style: ThemeTextStyle.regularIBM20sp.copyWith(
                    color: Colors.black54,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close, color: Colors.black54),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
