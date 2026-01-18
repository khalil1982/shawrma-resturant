import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

/// Date and time utility functions
class AppDateUtils {
  /// Format DateTime to database string (yyyy-MM-dd HH:mm:ss)
  static String toDbFormat(DateTime dateTime) {
    return DateFormat(AppConstants.dateTimeFormat).format(dateTime);
  }

  /// Format DateTime to date only string (yyyy-MM-dd)
  static String toDateOnlyFormat(DateTime dateTime) {
    return DateFormat(AppConstants.dateFormat).format(dateTime);
  }

  /// Format DateTime for display (dd/MM/yyyy)
  static String toDisplayDate(DateTime dateTime) {
    return DateFormat(AppConstants.displayDateFormat).format(dateTime);
  }

  /// Format DateTime for time display (HH:mm)
  static String toDisplayTime(DateTime dateTime) {
    return DateFormat(AppConstants.displayTimeFormat).format(dateTime);
  }

  /// Parse database string to DateTime
  static DateTime fromDbFormat(String dateString) {
    return DateFormat(AppConstants.dateTimeFormat).parse(dateString);
  }

  /// Get current date and time
  static DateTime now() {
    return DateTime.now();
  }

  /// Get today's date at midnight
  static DateTime today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Check if two dates are on the same day
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Get start of day
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get end of day
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }
}
