import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/ui/widgets/neuropathy_icons.dart';

import '../../../utils/themes/text_styles.dart';

class CommentsExpansionTile extends StatelessWidget {
  final String text;

  const CommentsExpansionTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Text(
          Languages.of(context)!.translate('results.comments.title'),
          style: ThemeTextStyle.regularIBM20sp,
        ),
        leading: Icon(
          NeuropathyIcons.ant_design_comment_outlined,
          size: 40,
          color: Theme.of(context).colorScheme.primary,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: ThemeTextStyle.regularIBM16sp,
            ),
          )
        ]);
  }
}