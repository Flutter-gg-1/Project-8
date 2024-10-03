part of 'add_menu_item_cubit.dart';

@immutable
sealed class AddMenuItemState {}

final class AddMenuItemInitial extends AddMenuItemState {}

final class UpdateUIState extends AddMenuItemState {}

final class LoadingState extends AddMenuItemState {}
