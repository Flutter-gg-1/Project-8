import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/date_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';

import '../add_offer_cubit.dart';

class DateBtnView extends StatelessWidget {
  const DateBtnView(
      {super.key, required this.cubit, required this.isStartDate});
  final bool isStartDate;
  final AddOfferCubit cubit;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    var date = isStartDate ? cubit.startDate : cubit.endDate;
    return ElevatedButton.icon(
      icon: Icon(
        Icons.calendar_today,
        color: C.primary(brightness),
      ),
      label: Text(date.toFormattedString()).styled(),
      onPressed: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          DateTime finalDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            date.hour,
            date.minute,
          );
          isStartDate
              ? cubit.updateStartDate(finalDateTime)
              : cubit.updateEndDate(finalDateTime);
        }
      },
    );
  }
}
