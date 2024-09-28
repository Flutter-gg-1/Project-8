import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'item_details_state.dart';

class ItemDetailsCubit extends Cubit<ItemDetailsState> {
  ItemDetailsCubit() : super(ItemDetailsInitial());
  int selectedIndex = -1;
  int selectStrengthIndex = -1;
  int itemCount = 1; 
  int sliderValue = 0;
  void selectSize(int index) {
    selectedIndex = index;
    emit(UpdatedSizeState(
      selectedIndex,
    ));
  }

  void selectStrength(int index) {
    selectStrengthIndex = index;
    emit(UpdatedStrengthState(selectStrengthIndex));
  }
  void incrementCount() {
    
    itemCount++;
    emit(UpdatedCountState(itemCount));
  }
  void decrementCount() {
    if (itemCount > 1) {
      itemCount--;
      emit(UpdatedCountState( itemCount));
    }
  }
  void updateSliderValue(int value) {
    sliderValue = value; 
    emit(UpdatedSliderValueState(sliderValue)); 
  }
}
