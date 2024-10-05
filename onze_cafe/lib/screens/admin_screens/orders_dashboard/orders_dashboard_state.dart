part of 'orders_dashboard_cubit.dart';

@immutable
sealed class OrdersDashboardState {}

final class OrdersDashboardInitial extends OrdersDashboardState {}

final class LoadingState extends OrdersDashboardState {}

final class UpdateUIState extends OrdersDashboardState {}

class OrderDashboardCardSelectedState extends OrdersDashboardState {
  final int selectedIndex;
  OrderDashboardCardSelectedState(this.selectedIndex);
}
