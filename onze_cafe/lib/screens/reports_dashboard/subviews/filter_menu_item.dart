import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/enums/days_filter.dart';
import 'package:onze_cafe/screens/reports_dashboard/reports_cubit.dart';

class FilterMenuView extends StatelessWidget {
  const FilterMenuView({
    super.key,
    required this.selectedFilter,
    required this.cubit,
  });

  final DaysFilter? selectedFilter;
  final ReportsCubit cubit;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: C.bg3(brightness),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButton<DaysFilter>(
          dropdownColor: C.bg3(brightness),
          value: selectedFilter,
          selectedItemBuilder: (context) => DaysFilter.values
              .map((filter) => Text(filter.name()).styled(
                  size: 16,
                  weight: FontWeight.w600,
                  color: C.primary(brightness)))
              .toList(),
          items: DaysFilter.values
              .map((filter) => DropdownMenuItem<DaysFilter>(
                    value: filter,
                    child: Text(filter.name()).styled(),
                  ))
              .toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              cubit.updateFilter(newValue);
            }
          },
        ),
      ),
    );
  }
}
