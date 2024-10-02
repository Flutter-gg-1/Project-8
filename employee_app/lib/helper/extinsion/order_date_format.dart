import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
extension OrderDateFormat on BuildContext {
String formatOrderTime({required String timeAsString}) {
  DateTime dateTime = DateTime.parse(timeAsString);

  String formattedDate = DateFormat('MM-dd HH:mm').format(dateTime);

  return formattedDate;
}
}