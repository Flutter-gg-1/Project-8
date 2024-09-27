import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String toFormattedString() {
    return DateFormat('MM/dd/yyyy').format(this);
  }
}

extension StringToDateTime on String {
  DateTime toDateTime() {
    return DateFormat('MM/dd/yyyy').parse(this);
  }
}
