import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';

import '../add_offer_cubit.dart';

class TimeBtnView extends StatelessWidget {
  const TimeBtnView(
      {super.key, required this.isStartDate, required this.cubit});
  final bool isStartDate;
  final AddOfferCubit cubit;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    var date = isStartDate ? cubit.startDate : cubit.endDate;
    return ElevatedButton.icon(
      icon: Icon(
        Icons.access_time,
        color: C.primary(brightness),
      ),
      label: Text(TimeOfDay.fromDateTime(date).format(context)).styled(),
      onPressed: () async {
        // Show time picker
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        // If a time was picked, update the Cubit state
        if (pickedTime != null) {
          // Combine the selected time with the existing date
          DateTime finalDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          isStartDate
              ? cubit.updateStartDate(finalDateTime)
              : cubit.updateEndDate(finalDateTime);
        }
      },
    );
  }
}
