import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'orders_dashboard_state.dart';

class OrdersDashboardCubit extends Cubit<OrderDashboardState> {
  OrdersDashboardCubit() : super(OrderDashboardInitial());
  bool isGradientToggled = false;

 void setActiveIcon(int index) {
    emit(OrderDashboardCardSelectedState(index));
  }
}
