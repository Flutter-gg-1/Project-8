enum DaysFilter { today, week, month }

extension TextValue on DaysFilter {
  String name() {
    switch (this) {
      case DaysFilter.today:
        return 'Today';
      case DaysFilter.week:
        return 'Week';
      case DaysFilter.month:
        return 'Month';
    }
  }
}
