// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../languages.dart';

class PanelItem {
  IconData icon;
  bool isExpanded;
  String title;
  PanelItem({
    required this.icon,
    this.isExpanded = false,
    required this.title,
  });
}

class PanelItemHeaderWidget extends StatelessWidget {
  final PanelItem panelItem;

  const PanelItemHeaderWidget({
    super.key,
    required this.panelItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        panelItem.icon,
        color: Theme.of(context).colorScheme.primary,
        size: 25,
      ),
      title: Text(Languages.of(context)!.translate(panelItem.title)),
    );
  }
}
