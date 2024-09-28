part of 'item_details_cubit.dart';

@immutable
sealed class ItemDetailsState {}

final class ItemDetailsInitial extends ItemDetailsState {}

final class UpdatedItemDetailsState extends ItemDetailsState {}

final class SuccessItemDetailsState extends ItemDetailsState {}

final class ErrorItemDetailsState extends ItemDetailsState {}

final class UpdatedSizeState extends ItemDetailsState {
  final int selectedSizeIndex;

  UpdatedSizeState(
    this.selectedSizeIndex,
  );
}

final class UpdatedStrengthState extends ItemDetailsState {
  final int selectedStrengthIndex;

  UpdatedStrengthState(this.selectedStrengthIndex);
}

final class UpdatedCountState extends ItemDetailsState {
  final int selectedCountIndex;

  UpdatedCountState(this.selectedCountIndex);
}

final class UpdatedSliderValueState extends ItemDetailsState {
  final int sliderValue;
  UpdatedSliderValueState(this.sliderValue);
}
