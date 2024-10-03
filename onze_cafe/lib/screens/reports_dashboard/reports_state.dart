part of 'reports_cubit.dart';

@immutable
sealed class ReportsState {}

final class ReportsInitial extends ReportsState {}
final class LoadingReportsState extends ReportsState {}
final class SuccessReportsState extends ReportsState {}
final class ErrorReportsState extends ReportsState {}
class ReportsFilterSelected extends ReportsState {
  final DaysFilter selected;
  ReportsFilterSelected(this.selected);
}

