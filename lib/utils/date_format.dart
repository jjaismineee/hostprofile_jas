// Small formatters so the project needs no `intl` dependency.
// Swap for `intl` if you need localization.

const _months = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December',
];

/// "May 2018"
String formatMonthYear(DateTime d) => '${_months[d.month - 1]} ${d.year}';

/// "February 12, 2026"
String formatLongDate(DateTime d) =>
    '${_months[d.month - 1]} ${d.day}, ${d.year}';

/// "1:00 PM"
String formatTime(DateTime d) {
  final hour12 = d.hour % 12 == 0 ? 12 : d.hour % 12;
  final minute = d.minute.toString().padLeft(2, '0');
  final suffix = d.hour >= 12 ? 'PM' : 'AM';
  return '$hour12:$minute $suffix';
}

/// "1:00 PM - 4:00 PM"
String formatTimeRange(DateTime start, DateTime end) =>
    '${formatTime(start)} - ${formatTime(end)}';
