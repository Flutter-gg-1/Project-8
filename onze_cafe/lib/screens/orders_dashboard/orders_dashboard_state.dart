part of 'orders_dashboard_cubit.dart';

@immutable
sealed class OrderDashboardState {}

final class OrderDashboardInitial extends OrderDashboardState {}
final class SuccessOrderDashboardState extends OrderDashboardState {}
final class LoadingOrderDashboardState extends OrderDashboardState {}
final class ErrorOrderDashboardState extends OrderDashboardState {}

class OrderDashboardCardSelectedState extends OrderDashboardState {
  final int selectedIndex;
  OrderDashboardCardSelectedState(this.selectedIndex);
}

