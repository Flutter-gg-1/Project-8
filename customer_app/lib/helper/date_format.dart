import 'package:intl/intl.dart';

String formatTimestamp({required String timestamp}) {
  DateTime dateTime = DateTime.parse(timestamp);

  String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

  return formattedDate;
}
