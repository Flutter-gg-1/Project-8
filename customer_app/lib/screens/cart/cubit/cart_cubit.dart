import 'package:bloc/bloc.dart';
import 'package:customer_app/data_layer/product_layer.dart';
import 'package:customer_app/models/order_model.dart';
import 'package:customer_app/services/setup.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  List<OrderModel> cartLis = productLocator.get<ProductLayer>().cartItem;

  CartCubit() : super(CartInitial());



  showCart(){

    


  }
}
