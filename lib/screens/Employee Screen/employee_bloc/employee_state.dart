part of 'employee_bloc.dart';

@immutable
sealed class EmployeeState {}

final class EmployeeInitial extends EmployeeState {}

final class SuccessfullLoadState extends EmployeeState {
  final List<dynamic> orders;

  SuccessfullLoadState({required this.orders});
}

final class ReadySuccessState extends EmployeeState {}

final class CancelSuccessState extends EmployeeState {}

final class ErrorState extends EmployeeState {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}
