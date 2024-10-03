import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'orders_dashboard_state.dart';

class OrdersDashboardCubit extends Cubit<OrdersDashboardState> {
  OrdersDashboardCubit() : super(OrdersDashboardInitial());
  bool isGradientToggled = false;

  void setActiveIcon(int index) {
    emit(OrderDashboardCardSelectedState(index));
  }
}
