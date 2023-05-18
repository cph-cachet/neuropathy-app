import 'package:intl/intl.dart';

import '../languages.dart';

class DateFormatter {
  Languages languages;

  DateFormatter(this.languages);

  String getFormattedTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime localDateTime = dateTime.toLocal();
    String timeString = DateFormat('jm').format(dateTime);

    if (now.year == localDateTime.year &&
        now.month == localDateTime.month &&
        now.day == localDateTime.day) {
      String today = languages.translate('result-screen.today');
      return '$today, $timeString';
    } else if (now.year == localDateTime.year &&
        now.month == localDateTime.month &&
        now.day == localDateTime.day + 1) {
      String yesterday = languages.translate('result-screen.yesterday');
      return '$yesterday, $timeString';
    } else if (now.difference(localDateTime).inDays < 7) {
      String weekDay = DateFormat('EEEE', languages.locale.toLanguageTag())
          .format(localDateTime);
      return '$weekDay, $timeString';
    }
    String date = DateFormat('dd/MM/yyyy').format(localDateTime);
    return '$date, $timeString';
  }
}
