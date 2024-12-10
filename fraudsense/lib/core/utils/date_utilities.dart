import 'package:intl/intl.dart' as intl;

class DateUtilities {
  static String getFormattedDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  static String getCurrentDate() {
    return intl.DateFormat('yMd').format(DateTime.now());
  }
}
