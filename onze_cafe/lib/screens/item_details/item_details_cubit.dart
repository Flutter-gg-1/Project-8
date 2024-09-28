import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'item_details_state.dart';

class ItemDetailsCubit extends Cubit<ItemDetailsState> {
  ItemDetailsCubit() : super(ItemDetailsInitial());
  void selectSize(int index) {
    //emit(index);
  }
}
