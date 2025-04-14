/// Extension cho DateTime
extension DateTimeExtension on DateTime {
  /// Format date thành dd/MM/yyyy
  String get toDateString => '$day/${month.toString().padLeft(2, '0')}/$year';

  /// Format date thành HH:mm
  String get toTimeString =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  /// Format date thành dd/MM/yyyy HH:mm
  String get toDateTimeString => '$toDateString $toTimeString';

  /// Kiểm tra xem có phải là cùng ngày không
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Kiểm tra xem có phải là hôm nay không
  bool get isToday => isSameDay(DateTime.now());

  /// Kiểm tra xem có phải là hôm qua không
  bool get isYesterday =>
      isSameDay(DateTime.now().subtract(const Duration(days: 1)));

  /// Get start of day (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  /// Get end of day (23:59:59)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);
}
