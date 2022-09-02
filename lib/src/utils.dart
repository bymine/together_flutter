import 'package:intl/intl.dart';

class Utils {
  static String formatTime(DateTime date) {
    return DateFormat("aa hh:mm").format(date);
  }

  static String formatDate(DateTime date, String seperator) {
    return DateFormat("yyyy${seperator}MM${seperator}dd").format(date);
  }

  static int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  static String formatScheduleTime(DateTime start, DateTime end) {
    String string1 = DateFormat("hh:mm a").format(start);
    String string2 = DateFormat("hh:mm a").format(end);

    return "$string1 ~ $string2";
  }
}
