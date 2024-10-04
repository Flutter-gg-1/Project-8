part of 'add_item_cubit.dart';

@immutable
sealed class AddItemState {}

final class AddItemInitial extends AddItemState {}

final class LodingState extends AddItemState {}
final class DoneState extends AddItemState {}

final class ErorrState extends AddItemState {
  final String msg;

  ErorrState({required this.msg});
}
