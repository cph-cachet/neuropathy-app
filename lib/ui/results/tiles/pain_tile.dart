import 'package:flutter/material.dart';
import 'package:research_package/model.dart';

import '../../../utils/themes/text_styles.dart';
import '../../widgets/neuropathy_icons.dart';

class PainTile extends StatelessWidget {
  final RPTaskResult taskResult;

  const PainTile({super.key, required this.taskResult});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Pain',
        style: ThemeTextStyle.regularIBM20sp,
      ),
      leading: Icon(
        NeuropathyIcons.bandaid_outline,
        size: 40,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
