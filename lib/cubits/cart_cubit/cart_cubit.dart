import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:onze_coffee_app/data_layer/user_layer.dart';
import 'package:onze_coffee_app/models/cart_product_model.dart';
import 'package:onze_coffee_app/models/product_model.dart';
import 'package:onze_coffee_app/models/variants_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final userDataLayer = GetIt.I.get<UserLayer>();
  late double totalAmount = GetIt.I.get<UserLayer>().totalAmount;

  CartCubit() : super(CartInitial());

  addItemsToCart(
      {required ProductModel product,
      required int qnty,
      required VariantsModel productVarient}) {
    if (!isClosed) emit(LoadingCartState());
    if (userDataLayer.myCart.isNotEmpty) {
      CartProductModel x = userDataLayer.myCart.firstWhere(
          (CartProductModel c) => c.productID == product.productId,
          orElse: () => (CartProductModel(
              productName: "",
              tempreture: "",
              productPrice: -1,
              quantity: -1,
              productID: -1)));
      if (x.productID != -1) {
        int index = userDataLayer.myCart.indexOf(x);
        updateIncreamentAmount(
            price: productVarient.price,
            qnt: userDataLayer.myCart[index].quantity++);
        emit(SuccessCartState(msg: "Done :)"));
        return true;
      } else {
        userDataLayer.myCart.add(CartProductModel(
            productName: product.productName,
            tempreture: product.tempreture,
            productPrice: productVarient.price,
            quantity: qnty,
            productID: product.productId));
        updateIncreamentAmount(price: productVarient.price, qnt: 1);
        emit(SuccessCartState(msg: "Done :)"));
      }
    } else {
      userDataLayer.myCart.add(CartProductModel(
          productName: product.productName,
          tempreture: product.tempreture,
          productPrice: productVarient.price,
          quantity: qnty,
          productID: product.productId));
      updateIncreamentAmount(price: productVarient.price, qnt: 1);
      emit(SuccessCartState(msg: "Done :)"));
    }
  }

  updateIncreamentAmount({required num price, required int qnt}) {
    // totalAmount += (price * qnt);
    totalAmount = (price * qnt).toDouble();
    emit(SuccessCartState(msg: "Done:)"));
  }

  double getAllAmountItems({required List<CartProductModel> cart}) {
    double sum = 0;
    for (var element in cart) {
      sum += element.productPrice * element.quantity;
    }
    if (!isClosed) emit(SuccessCartState(msg: "Done:)"));
    return sum;
  }

  updateDecreaseAmount({required CartProductModel cart}) {
    if (cart.quantity <= 0) {
      userDataLayer.myCart.remove(cart);
      totalAmount = 0;
      emit(SuccessCartState(msg: "Done:)"));
    } else {
      totalAmount = totalAmount - cart.productPrice;
      emit(SuccessCartState(msg: "Done:)"));
    }
  }
}