part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}
abstract class HomeBlocEvent {}

class LoadProductsEvent extends HomeBlocEvent {
  final String itemType;
  LoadProductsEvent(this.itemType);
}