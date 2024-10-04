part of 'employee_bloc.dart';

@immutable
sealed class EmployeeEvent {}

final class LoadEvent extends EmployeeEvent {}
final class LoadNewOrderEvent extends EmployeeEvent {
  final Map<String, dynamic> order;

  LoadNewOrderEvent({required this.order});
}

final class ReadyEvent extends EmployeeEvent {
  final Map<String, dynamic> order;

  ReadyEvent({required this.order});
}

final class CancelEvent extends EmployeeEvent {
  final Map<String, dynamic> order;

  CancelEvent({required this.order});
}
