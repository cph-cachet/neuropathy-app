import 'package:flutter/material.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';

class IconRowWithText extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const IconRowWithText({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.min,
      children: [
        FittedBox(
            fit: BoxFit.fill,
            child: Icon(
              icon,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            )),
        //SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: ThemeTextStyle.regularIBM20sp),
            Text(subtitle, style: ThemeTextStyle.extraLightIBM16sp),
          ],
        ),
      ],
    );
  }
}
