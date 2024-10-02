part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

final class GetFavItemsEvent extends FavoriteEvent {}

// final class AddToFavEvent extends FavoriteEvent {
//   final String itemId;
//   AddToFavEvent({required this.itemId});
// }

class ToggleFavoriteEvent extends FavoriteEvent {
  final ItemModel item;
  ToggleFavoriteEvent({required this.item});
}