part of 'employee_dashboard_cubit.dart';

@immutable
sealed class EmployeeDashboardState {}

final class EmployeeDashboardInitial extends EmployeeDashboardState {}

final class LoadingState extends EmployeeDashboardState {}

final class UpdateUIState extends EmployeeDashboardState {}
