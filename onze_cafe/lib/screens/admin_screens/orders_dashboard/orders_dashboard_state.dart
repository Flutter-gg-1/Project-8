part of 'orders_dashboard_cubit.dart';

@immutable
sealed class OrdersDashboardState {}

final class OrdersDashboardInitial extends OrdersDashboardState {}

final class SuccessOrderDashboardState extends OrdersDashboardState {}

final class LoadingOrderDashboardState extends OrdersDashboardState {}

final class ErrorOrderDashboardState extends OrdersDashboardState {}

class OrderDashboardCardSelectedState extends OrdersDashboardState {
  final int selectedIndex;
  OrderDashboardCardSelectedState(this.selectedIndex);
}
