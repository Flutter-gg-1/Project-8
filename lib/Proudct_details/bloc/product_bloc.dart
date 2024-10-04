import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/models/order_item_model.dart';
import 'package:onze_cafe/services/setup.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductDetailsBloc extends Bloc<ProductEvent, ProductState> {
  ProductDetailsBloc(DataLayer dataLayer) : super(ProductInitial()) {
    on<AddToCartEvent>((event, emit) async {
      emit(ProductDetailsLoading());
      try {
        await locator.get<DataLayer>().addItem(
              item: OrderItemModel.fromJson({
                'item_id': event.itemId,
                'order_id': event.orderId,
                'quantity': event.quantity,
                'price': event.price,
              }),
            );
        emit(ProductDetailsSuccess('Added to cart!'));
      } catch (e) {


        emit(ProductDetailsFailure('Failed to add to cart. $e'));
      }
    });

    on<ChangeQuantityEvent>((event, emit) {
      emit(ProductQuantityUpdated(event.quantity));
    });

    on<ChangeSizeEvent>((event, emit) {
      print(event.selectedSize.toString());
      final size = event.selectedSize ?? '8 oz';
      emit(ProductSizeUpdated(size));
    });
  }
}
