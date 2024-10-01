import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/models/item_model.dart';

part 'home_event.dart';
part 'home_state.dart';



class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  final DataLayer dataLayer;

  HomeBloc(this.dataLayer) : super(HomeLoadingState()) {
    on<LoadProductsEvent>((event, emit) async {
      try {
        emit(HomeLoadingState());
        final products = await dataLayer.getItemsByType(event.itemType);
        emit(HomeLoadedState(products));
      } catch (e) {
        emit(HomeErrorState(e.toString()));
      }
    });
  }
}
