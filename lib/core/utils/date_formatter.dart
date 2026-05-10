import 'package:intl/intl.dart';

String formatDate(String date) {
  try {
    final parsed = DateTime.parse(date);
    return DateFormat('dd.MM.yyyy').format(parsed);
  } catch (_) {
    return date;
  }
}