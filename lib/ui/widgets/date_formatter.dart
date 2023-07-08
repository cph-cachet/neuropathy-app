import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:neuropathy_grading_tool/languages.dart';

/// A class that formats a [dateTime] object to a localized display Text. Returns a [Text] widget,
/// with optional [style] parameter.
///
/// It renders the date in the following format:
/// - if the date is today, it returns 'Today, HH:mm'
/// - if the date is yesterday, it returns 'Yesterday, HH:mm'
/// - if the date is within the last week, it returns 'Weekday, HH:mm'
/// - otherwise it returns 'dd/MM/yyyy, HH:mm'
class FormattedDateText extends StatelessWidget {
  final DateTime dateTime;
  final TextStyle? style;

  const FormattedDateText({super.key, required this.dateTime, this.style});

  String getFormattedTime(DateTime dateTime, BuildContext context) {
    DateTime now = DateTime.now();
    DateTime localDateTime = dateTime.toLocal();
    String timeString = DateFormat('Hm').format(dateTime);

    if (now.year == localDateTime.year &&
        now.month == localDateTime.month &&
        now.day == localDateTime.day) {
      String today = Languages.of(context)!.translate('common.today');
      return '$today, $timeString';
    } else if (now.year == localDateTime.year &&
        now.month == localDateTime.month &&
        now.day == localDateTime.day + 1) {
      String yesterday = Languages.of(context)!.translate('common.yesterday');
      return '$yesterday, $timeString';
    } else if (now.difference(localDateTime).inDays < 7) {
      String weekDay =
          DateFormat('EEEE', Languages.of(context)!.locale.toLanguageTag())
              .format(localDateTime);
      return '$weekDay, $timeString';
    }
    String date = DateFormat('dd/MM/yyyy').format(localDateTime);
    return '$date, $timeString';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      getFormattedTime(dateTime, context),
      style: style,
    );
  }
}
