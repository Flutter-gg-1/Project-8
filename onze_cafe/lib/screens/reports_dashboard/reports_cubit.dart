import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onze_cafe/model/enums/days_filter.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit() : super(ReportsInitial());

  void updateFilter(DaysFilter filter) {
    emit(ReportsFilterSelected(filter));
  }
}
