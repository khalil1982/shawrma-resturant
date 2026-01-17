import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

/// مساعد التواريخ
class DateHelper {
  DateHelper._();

  /// تنسيق التاريخ والوقت
  static final DateFormat _dateTimeFormatter = DateFormat(AppConstants.dateTimeFormat);

  /// تنسيق التاريخ فقط
  static final DateFormat _dateFormatter = DateFormat(AppConstants.dateFormat);

  /// تنسيق الوقت فقط
  static final DateFormat _timeFormatter = DateFormat(AppConstants.timeFormat);

  /// تنسيق التاريخ للتقارير
  static final DateFormat _reportDateFormatter = DateFormat(AppConstants.reportDateFormat);

  /// الحصول على التاريخ والوقت الحالي كنص
  static String now() {
    return _dateTimeFormatter.format(DateTime.now());
  }

  /// الحصول على التاريخ الحالي كنص
  static String today() {
    return _dateFormatter.format(DateTime.now());
  }

  /// الحصول على الوقت الحالي كنص
  static String currentTime() {
    return _timeFormatter.format(DateTime.now());
  }

  /// تحويل DateTime إلى نص بتنسيق قاعدة البيانات
  static String formatDateTime(DateTime dateTime) {
    return _dateTimeFormatter.format(dateTime);
  }

  /// تحويل DateTime إلى نص تاريخ فقط
  static String formatDate(DateTime dateTime) {
    return _dateFormatter.format(dateTime);
  }

  /// تحويل DateTime إلى نص وقت فقط
  static String formatTime(DateTime dateTime) {
    return _timeFormatter.format(dateTime);
  }

  /// تحويل DateTime إلى تنسيق التقارير
  static String formatForReport(DateTime dateTime) {
    return _reportDateFormatter.format(dateTime);
  }

  /// تحويل نص إلى DateTime
  static DateTime? parseDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return null;
    try {
      return _dateTimeFormatter.parse(dateTimeString);
    } catch (e) {
      return null;
    }
  }

  /// تحويل نص إلى تاريخ
  static DateTime? parseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      return _dateFormatter.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// الحصول على بداية اليوم
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 0, 0, 0);
  }

  /// الحصول على نهاية اليوم
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  /// الحصول على بداية الشهر
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1, 0, 0, 0);
  }

  /// الحصول على نهاية الشهر
  static DateTime endOfMonth(DateTime date) {
    final nextMonth = date.month == 12
        ? DateTime(date.year + 1, 1, 1)
        : DateTime(date.year, date.month + 1, 1);
    return nextMonth.subtract(const Duration(seconds: 1));
  }

  /// الحصول على بداية الأسبوع
  static DateTime startOfWeek(DateTime date) {
    final daysToSubtract = date.weekday - 1;
    final startDate = date.subtract(Duration(days: daysToSubtract));
    return startOfDay(startDate);
  }

  /// الحصول على نهاية الأسبوع
  static DateTime endOfWeek(DateTime date) {
    final daysToAdd = 7 - date.weekday;
    final endDate = date.add(Duration(days: daysToAdd));
    return endOfDay(endDate);
  }

  /// التحقق من أن التاريخ اليوم
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// التحقق من أن التاريخ في الماضي
  static bool isPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  /// التحقق من أن التاريخ في المستقبل
  static bool isFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  /// الفرق بالأيام بين تاريخين
  static int daysBetween(DateTime from, DateTime to) {
    final fromDate = DateTime(from.year, from.month, from.day);
    final toDate = DateTime(to.year, to.month, to.day);
    return toDate.difference(fromDate).inDays;
  }

  /// تنسيق المدة الزمنية
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours س $minutes د';
    } else if (minutes > 0) {
      return '$minutes د $seconds ث';
    } else {
      return '$seconds ث';
    }
  }

  /// الحصول على اسم اليوم بالعربية
  static String getArabicDayName(DateTime date) {
    const days = [
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];
    return days[date.weekday - 1];
  }

  /// الحصول على اسم الشهر بالعربية
  static String getArabicMonthName(DateTime date) {
    const months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    return months[date.month - 1];
  }

  /// تنسيق التاريخ بالعربية الكامل
  static String formatArabicDate(DateTime date) {
    return '${getArabicDayName(date)} ${date.day} ${getArabicMonthName(date)} ${date.year}';
  }
}
