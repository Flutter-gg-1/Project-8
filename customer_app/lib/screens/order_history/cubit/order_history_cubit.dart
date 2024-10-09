import 'package:bloc/bloc.dart';
import 'package:customer_app/DB/super_main.dart';
import 'package:customer_app/models/order_details_model.dart';
import 'package:customer_app/models/order_model.dart';
import 'package:customer_app/models/product_model.dart';
import 'package:meta/meta.dart';

part 'order_history_state.dart';

class OrderShowCubit extends Cubit<OrderShowState> {
  OrderShowCubit() : super(OrderHistoryInitial());

  List<OrderModel> orderList = [];

  getAllUserOrder({String? status}) async {
    try {
      await Future.delayed(Duration.zero);
      emit(LoadingState());
      orderList.clear();
      final res = await SuperMain().getUserOrder(status: status);

      for (var val in res) {
        orderList.add(OrderModel.fromJson(val));
      }

      for (var val in orderList) {
        final orderRes =
            await SuperMain().getAllUserOrderDetail(orderId: val.orderId!);

        for (var orderVal in orderRes) {
          OrderDetailsModel temp = OrderDetailsModel.fromJson(orderVal);

          temp.productModel = ProductModel.fromJson(
              await SuperMain().getProductById(productId: temp.productId));

          val.orderDetailsLis.add(temp);
        }
      }
      emit(SussesState());
      emit(OrderHistoryShowDataState());
    } catch (er) {
      emit(ErrorState(msg: 'Sorry some problem happen try again later'));
    }
  }

  getTotalQueAndPrice({required int index}) {
    int totalQue = 0;

    for (var val in orderList[index].orderDetailsLis) {
      totalQue += val.quantity ?? 0;
    }

    return "X$totalQue ${orderList[index].totalPrice} SAR";
  }
}
